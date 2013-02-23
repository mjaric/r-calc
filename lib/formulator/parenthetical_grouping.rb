require 'formulator/pusher'
require 'formulator/popper'

module Formulator

# Mix-ins for the usual operations.  See ExpressionProcessor#initialize for how
# these "AddOperator_" methods get invoked.

# First, parenthetical grouping
  module ParentheticalGrouping
    def AddOperators_ParentheticalGrouping

      # Define "(" and ")" as our grouping operators

      @operators << ::Formulator::Pusher.new("(")
      @operators << ::Formulator::Popper.new(")")
    end
  end

end