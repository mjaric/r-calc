require 'formulator/operator'

class Formulator::BinOrUnOperator < ::Formulator::Operator
  private
  def initialize(symbol, priority)
    super(symbol, 1, 2, priority)
  end
end