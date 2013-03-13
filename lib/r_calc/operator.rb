require 'r_calc/parse_token'


=begin
An operator (or function identifier)
=end
class RCalc::Operator < RCalc::ParseToken
  attr_reader :proc, :minarg, :maxarg, :priorityProc
  attr_writer :priorityProc

  private
  def initialize(symbol, minarg, maxarg, priority, &proc)
    super(symbol, RCalc::ParseToken::PARSE_OP)
    @minarg = minarg # minimum number of operands
    @maxarg = maxarg # maximum number of operands
    @priority = priority # operator precedence (0 = low .. 5 = high)
    @proc = proc # code block for performing the operation
    @priorityProc = nil # procedure for determining priority
                        # (we need this for operators that determine
                        #  priority based on context, like + and -
  end

  public
  # Get priority of the operator
  def priority(operandPreceding = nil)
    # only determine priority once, possibly based on context
    if (!(@priority) && @priorityProc) # do we have a proc for processing priority?
      @priority = @priorityProc.call(operandPreceding) # call it
    end
    @priority # return it
  end
end
