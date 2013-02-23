require 'formulator/binary_operator'


# = for assignment
module Formulator
  module AssignmentOperator
    def AddOperators_Assignment
      @operators << (::Formulator::BinaryOperator.new("=", 1) { |x, y| x.value = y.value })
    end
  end
end