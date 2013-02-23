require 'formulator/function'
# $ for last result
module Formulator
  module LastResultOperator
    def AddOperators_LastResult
      @operators << ::Formulator::Function.new("$", 0, 0) { self.last_result }
    end
  end
end