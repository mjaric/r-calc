require 'r_calc/parse_token'
require 'r_calc/operator'
require 'r_calc/unary_operator'
require 'r_calc/binary_operator'
require 'r_calc/binary_or_unary_operator'
require 'r_calc/function'
require 'r_calc/pusher'
require 'r_calc/popper'
require 'r_calc/separator'
require 'r_calc/identifier'
require 'r_calc/literal'
require 'r_calc/operator_list'
require 'r_calc/parse_token'


module RCalc
# An expression processor.  This class can be derived to process many types of
# expressions.  The modules defined below can be included in a derived class to
# support popular sets of operations, or you can define your own.
# The code block passed to the new method for this class is used for evaluating
# identifiers in the expression.  This allows the client code to supply/store
# variables in any way it wishes.
  class FormulaProcessor
    attr_reader :operators, :last_result, :receipt_components
    private
    def initialize(&proc)
      @proc = proc # code block for accessing values for identifiers
      @operators = OperatorList.new # hash for operators
      @operators << Separator.new(',') # comma separates by default
      @curr = nil # current operand stack
      @currop = nil # current operator
      @opstack = nil # stack of operators
      @last_result = nil # result of last expression
      @receipt_components =[] # the list of local identifiers which was used to store
                   # values carried to next calculation

                   # Here's a nifty little trick.  We'll inspect our methods and call any method
                   # whose name starts with "AddOperator_".  That allows a derived class to include
                   # any of the operator modules defined below, and automatically get support
                   # for the operators included in each module, without having to invoke the
                   # methods explicitly.

      methods.each do |name|
        self.send(name) if (name =~ /^AddOperators_/)
      end
    end

    # Resolve the expression composed of the current operator (@currop) and the
    # current operand stack (@curr)

    def resolve
      if (@currop) then # Do we have an operator?
        args = @curr[1..-1] # omit the "pusher" (curr[0] is always a Pusher)

        # check argument count requirements

        if (@currop.minarg && (args.length < @currop.minarg))
          raise(FormulaExpressionException, "Not enough arguments for operation '#{@currop.symbol}'\nMinimum: #{@currop.minarg}, encountered #{args.length}")
        end
        if (@currop.maxarg && (args.length > @currop.maxarg))
          raise(FormulaExpressionException, "Too many arguments for operation '#{@currop.symbol}'\nMaximum: #{@currop.maxarg}, encountered #{args.length}")
        end

        # Call the operator's code block and store the result as element 1, trimming the other operands

        @curr[1..-1] = Literal.new(@currop.proc.call(*args))
        @currop = nil # No more current operator
      end
      if (@curr[0].implied) # pop off any implied Pusher
        val = @curr[1] # grab the value
        @curr = @curr[0].parent # pop back up to the parent operand stack
        @curr[-1] = val # store the value over the reference to the stack we just popped
        @currop = @opstack.pop # pop off the operator from the previous level
      end
      return @curr[-1] # In either case, return the last value on the current operand stack
    end


    public
    # Evaluate an expression
    def eval(input=$_) # default to current string if not passed
      stack = [Pusher.new(nil)] # operand array (a stack of operands and/or operand stacks)
      @opstack = [] # operator stack
      @curr = stack # current operand stack
      @currop = nil # operator at current stack level

      # Tokenize as numeric or identifier or non-space/comma (presumably an operator or parentheses)
      input.scan(/[0-9.]+|\w+|,|[^\s\t\r\n\f]/) do |token|
        t = nil
        if (token =~ /^[0-9]+$/) then # integer literal
          t = Literal.new(token.to_i)
        elsif (token =~ /^[0-9.]+$/) then # floating point literal
          t = Literal.new(token.to_f)
        elsif (t = @operators[token]) then # a defined operator
        elsif (token =~ /^\w+$/) # an identifier
          t = Identifier.new(token, @proc)
          receipt_components << token unless receipt_components.include? token
        else
          raise(FormulaExpressionException, "Unrecognized character in expression: #{token}")
        end

        if (t) # Did we create something?
          case t.parseAction # What are we to do with it?
            when ParseToken::PARSE_VALUE # Literals and identifiers
              @curr.push(t) #  get pushed as operands

            when ParseToken::PARSE_OP # Operators and functions
              t = t.clone # Must copy to establish priority independently

              # Get the priority (note our only context-based syntax element, a leading operand)
              prior = t.priority(opPreceding = @currop ? (@curr.length > 2) : (@curr.length > 1))

              # If we already have an operator with at least equal priority, resolve it
              while (@currop && (prior <= @currop.priority))
                resolve
              end
              if (@currop) then # We found an operator of lower priority
                pusher = Pusher.new(nil) # Group our new operation (implied parenthesis)
                pusher.implied = true
                pusher.parent = @curr # back-link the stack
                if (opPreceding) then # operand preceding?
                  new = [pusher, @curr[-1]] # move last operand to new operation
                  @curr[-1] = new # link new stack to end of old one
                else
                  new = [pusher]
                  @curr.push(new) # just push and go
                end
                @curr = new # save reference to new operand stack
                @opstack.push(@currop) # push the previous operator
              end
              @currop = t # now we have a new operator

              # Resolve the operation if we already reached the maximum argument count
              resolve if (@currop.maxarg && (@curr.length > @currop.maxarg))

            when ParseToken::PARSE_PUSH # Grouping (parenthesis equivalent)
              t = t.clone # Clone so we have a unique parent property
              t.parent = @curr # Back-link to previous operand stack
              @curr.push(new = [t]) # Forward-link to new operand stack
              @curr = new # Save reference to new stack
              @opstack.push(@currop) # Push the current operator, if any
              @currop = nil # No current operator yet within this grouping

            when ParseToken::PARSE_POP # End grouping (close parenthesis)
              resolve while (@curr[0].implied) # Resolve all implied pushes first
              if (@currop) then # Do we have an operator?
                val = resolve # Resolve the contained operation

                # If we're already unwound, this is an extra one
                raise(FormulaExpressionException, "Unmatched #{t.symbol}") if (@curr == stack)
                @curr = @curr[0].parent # Pop back to parent stack
                @curr[-1] = val # Store the value over the forward reference (losing the reference)
              else # No current operator, just move the operands back
                val = @curr[1..-1] # Gather the operands
                @curr = @curr[0].parent # Pop back to parent stack
                @curr[-1, val.length] = val # Extend the operand stack with the new operands
              end
              @currop = @opstack.pop # Pop back to previous operator

            when ParseToken::PARSE_SEPARATE # Separator, like comma
              resolve if (@currop || @curr[0].implied) # Resolve any pending operation
              pusher = Pusher.new(nil) # Implied push to prevent folding operators across separator
              pusher.implied = true
              pusher.parent = @curr
              new = [pusher]
              @curr.push(new)
              @curr = new
              @opstack.push(@currop)
              @currop = nil
          end # case t.parseAction
        end # if (t)
      end # input.scan

      # Pop off any implied pushes, resolving the values
      resolve while (@curr[0].implied)

      # Make sure we unwound completely
      raise(FormulaExpressionException, "Unmatched #{@curr[0].symbol}") if (@curr != stack)

      # Resolve any final operator, and save the value
      @last_result = resolve.value

      # Make sure we ended up with just one value
      raise(FormulaExpressionException, "Missing operator") if (@curr.length > 2)

      # Return that value
      @last_result
    end

  end
end




