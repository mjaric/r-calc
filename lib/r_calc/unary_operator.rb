require 'r_calc/operator'


# An operator that takes only one operand

class RCalc::UnaryOperator < RCalc::Operator
  private
  def initialize(symbol, priority)
    super(symbol, 1, 1, priority)
  end
end
