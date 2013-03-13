require 'r_calc/function'
# $ for last result
module RCalc
  module LastResultOperator
    def AddOperators_LastResult
      @operators << ::RCalc::Function.new("$", 0, 0) { self.last_result }
    end
  end
end