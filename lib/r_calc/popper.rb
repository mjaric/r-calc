require 'r_calc/parse_token'

# The complementary close parenthesis (or equivalent)

class RCalc::Popper < RCalc::ParseToken
  private
  def initialize(symbol)
    super(symbol, RCalc::ParseToken::PARSE_POP)
  end
end