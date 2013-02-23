require 'formulator/binary_operator'
require 'formulator/binary_or_unary_operator'

# Arithmetic operators + - * / % ^
module Formulator
  module ArithmeticOperators
    def AddOperators_Arithmetic

      # Plus and minus are binary operators if they are preceeded by an operand.
      # Otherwise they are unary, and have higher priority.

      @operators << (plus = (BinOrUnOperator.new("+", nil) { |x, y| y ? x.value + y.value : x.value }))
      @operators << (minus = (BinOrUnOperator.new("-", nil) { |x, y| y ? x.value - y.value : -x.value }))

      # If a + or - has an operand preceding, the priority is lower than * and /,
      # but higher than =.  If no operand precedes, it is higher than * or /.
      # So, we create a code block to make this determination.

      pmPriority = Proc.new { |operandPreceding| operandPreceding ? 2 : 4 }

      # and assign it as the priorityProc for the + and - operators

      plus.priorityProc = pmPriority
      minus.priorityProc = pmPriority

      # Now we add some easy binary operators...

      @operators << (BinaryOperator.new("*", 3) { |x, y| x.value * y.value })
      @operators << (BinaryOperator.new("/", 3) { |x, y| x.value / y.value })
      @operators << (BinaryOperator.new("%", 3) { |x, y| x.value % y.value })
      @operators << (BinaryOperator.new("^", 3) { |x, y| x.value ** y.value })
    end
  end
end