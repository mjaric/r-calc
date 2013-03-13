require 'r_calc/formula_expression_exception'
require 'r_calc/parse_token'

class RCalc::Pusher < RCalc::ParseToken
  attr_reader :parent, :implied # parent operand array
  attr_writer :parent, :implied # implied means we created it via operator precedence
  private
  def initialize(symbol)
    super(symbol, RCalc::ParseToken::PARSE_PUSH)
    @implied = false # by default it is a literal token
  end

  public
  def value # Tried to evaluate one of these
    raise(RCalc::FormulaExpressionException, "Unrecognized expression")
  end
end