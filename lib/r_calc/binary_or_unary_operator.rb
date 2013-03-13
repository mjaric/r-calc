require 'r_calc/operator'

class RCalc::BinOrUnOperator < ::RCalc::Operator
  private
  def initialize(symbol, priority)
    super(symbol, 1, 2, priority)
  end
end