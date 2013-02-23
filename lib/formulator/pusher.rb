require 'formulator/formula_expression_exception'
require 'formulator/parse_token'

class Formulator::Pusher < Formulator::ParseToken
  attr_reader :parent, :implied # parent operand array
  attr_writer :parent, :implied # implied means we created it via operator precedence
  private
  def initialize(symbol)
    super(symbol, Formulator::ParseToken::PARSE_PUSH)
    @implied = false # by default it is a literal token
  end

  public
  def value # Tried to evaluate one of these
    raise(Formulator::FormulaExpressionException, "Unrecognized expression")
  end
end