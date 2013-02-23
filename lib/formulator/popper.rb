require 'formulator/parse_token'

# The complementary close parenthesis (or equivalent)

class Formulator::Popper < Formulator::ParseToken
  private
  def initialize(symbol)
    super(symbol, Formulator::ParseToken::PARSE_POP)
  end
end