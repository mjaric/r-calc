require 'formulator/operator'

# An operator that takes two operands
class Formulator::BinaryOperator < ::Formulator::Operator

  private
  def initialize(symbol, priority)
    super(symbol, 2, 2, priority)
  end
end
