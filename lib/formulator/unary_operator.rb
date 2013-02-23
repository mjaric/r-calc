require 'formulator/operator'


# An operator that takes only one operand

class Formulator::UnaryOperator < Formulator::Operator
  private
  def initialize(symbol, priority)
    super(symbol, 1, 1, priority)
  end
end
