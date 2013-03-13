require 'r_calc/operator'

# A function has the lowest priority, because usually the arguments are
# enclosed in a push/pop sequence (e.g., parentheses)

class RCalc::Function < ::RCalc::Operator
  private
  def initialize(name, minarg, maxarg)
    super(name, minarg, maxarg, 5)
  end
end