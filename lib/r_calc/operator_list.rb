# A special Hash for the list of supported operators
# The user can append new operators, without worrying about how we need to handle them.

class RCalc::OperatorList < Hash
  def <<(oper) # No need for the user to know about the keys
    self[oper.symbol] = oper # We use the operator's symbol for the key, BTW
  end
end