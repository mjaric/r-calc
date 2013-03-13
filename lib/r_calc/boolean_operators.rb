require 'r_calc/function'
require 'r_calc/binary_operator'
require 'r_calc/unary_operator'

module RCalc
  module BooleanOperators
    def AddOperators_Boolean

      # Functions for true and false

      @operators << ::RCalc::Function.new("true", 0, 0) { true }
      @operators << ::RCalc::Function.new("false", 0, 0) { false }

      # Equality and its clan (note we cannot use '==' or other two-character
      # non-word operators, because of the way we parse the string.  Non-word
      # characters come in one at a time.

      @operators << ::RCalc::BinaryOperator.new("eq", 3) { |x, y| x.value == y.value }
      @operators << ::RCalc::BinaryOperator.new("ne", 3) { |x, y| x.value != y.value }
      @operators << ::RCalc::BinaryOperator.new("gt", 3) { |x, y| x.value > y.value }
      @operators << ::RCalc::BinaryOperator.new("lt", 3) { |x, y| x.value < y.value }
      @operators << ::RCalc::BinaryOperator.new("ge", 3) { |x, y| x.value >= y.value }
      @operators << ::RCalc::BinaryOperator.new("le", 3) { |x, y| x.value <= y.value }

      # Boolean and/or

      @operators << ::RCalc::BinaryOperator.new("and", 2) { |x, y| x.value && y.value }
      @operators << ::RCalc::BinaryOperator.new("or", 2) { |x, y| x.value || y.value }

      # Logical not

      @operators << ::RCalc::UnaryOperator.new("not", 4) { |x| !x.value }

    end
  end
end