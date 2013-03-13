require 'r_calc/binary_operator'


# = for assignment
module RCalc
  module AssignmentOperator
    def AddOperators_Assignment
      @operators << (::RCalc::BinaryOperator.new("=", 1) { |x, y| x.value = y.value })
    end
  end
end