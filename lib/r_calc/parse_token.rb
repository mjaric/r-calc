=begin
Any token we might encounter in the expression
=end
class RCalc::ParseToken
  public
  # values for parseAction (what to do when we encounter this token):
  PARSE_VALUE = 0 # A literal or an identifier (stack it)
  PARSE_OP = 1 # An operator
  PARSE_PUSH = 2 # Open parenthesis, for example
  PARSE_POP = 3 # Close parenthesis, for example
  PARSE_SEPARATE = 4 # Comma, for example
  attr_reader :symbol, :parseAction
  private
  def initialize(symbol, parseAction)
    @symbol = symbol # symbol used for parsing
    @parseAction = parseAction # action when parsing
  end
end
