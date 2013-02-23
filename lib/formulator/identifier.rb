require 'formulator/parse_token'

# A token that presumably references a variable of some sort
# This class demonstrates calling a code block from a saved reference to it.

class Formulator::Identifier < Formulator::ParseToken
  private
  def initialize(name, proc)
    super(name, ::Formulator::ParseToken::PARSE_VALUE) # Note we use the name as the symbol
    @proc = proc # proc is a code block for evaluating the symbol
  end

  public
  def value=(newvalue) # Assign to value
    @proc.call(self.symbol, newvalue) # We pass newvalue to denote assignment
  end

  def value # Get value
    @proc.call(self.symbol) # No newvalue passed here
  end
end