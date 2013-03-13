require 'r_calc/parse_token'

# A separator, like comma

class RCalc::Separator < RCalc::ParseToken
  private
  def initialize(symbol)
    super(symbol, RCalc::ParseToken::PARSE_SEPARATE)
  end
end