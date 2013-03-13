require 'r_calc/operator'

# An operator that takes two operands
class RCalc::BinaryOperator < ::RCalc::Operator

  private
  def initialize(symbol, priority)
    super(symbol, 2, 2, priority)
  end
end
