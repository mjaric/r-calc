require 'formulator/parse_token'

# A separator, like comma

class Formulator::Separator < Formulator::ParseToken
  private
  def initialize(symbol)
    super(symbol, Formulator::ParseToken::PARSE_SEPARATE)
  end
end