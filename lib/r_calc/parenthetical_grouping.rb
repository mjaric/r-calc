require 'r_calc/pusher'
require 'r_calc/popper'

module RCalc

# Mix-ins for the usual operations.  See ExpressionProcessor#initialize for how
# these "AddOperator_" methods get invoked.

# First, parenthetical grouping
  module ParentheticalGrouping
    def AddOperators_ParentheticalGrouping

      # Define "(" and ")" as our grouping operators

      @operators << ::RCalc::Pusher.new("(")
      @operators << ::RCalc::Popper.new(")")
    end
  end

end