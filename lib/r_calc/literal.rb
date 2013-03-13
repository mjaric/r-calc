require 'r_calc/formula_expression_exception'
require 'r_calc/parse_token'
# A literal value

class RCalc::Literal < RCalc::ParseToken
  attr_reader :value # Just like an Identifier, we can get the
                     # value using the 'value' property, even
                     # though the implementation has nothing in common.
                     # The nice thing about Ruby is that these
                     # two classes do not need to be derived
                     # from an abstract parent class (less typing,
                     # in every sense of the word).
  private
  def initialize(value)
    super(value, ::RCalc::ParseToken::PARSE_VALUE) # Note we use the value itself as the symbol
    @value = value
  end

  public
                     # We could have left out the following method, but our version gives a better error
                     # messsage than the default "method missing value=".
  def value=(newvalue) # Assign a value
    raise(::RCalc::FormulaExpressionException, "Writing into a literal") # Not!
  end
end