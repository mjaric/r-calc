require 'formulator/function'
require 'formulator/binary_operator'
require 'formulator/unary_operator'

module Formulator
  module BooleanOperators
    def AddOperators_Boolean

      # Functions for true and false

      @operators << ::Formulator::Function.new("true", 0, 0) { true }
      @operators << ::Formulator::Function.new("false", 0, 0) { false }

      # Equality and its clan (note we cannot use '==' or other two-character
      # non-word operators, because of the way we parse the string.  Non-word
      # characters come in one at a time.

      @operators << ::Formulator::BinaryOperator.new("eq", 3) { |x, y| x.value == y.value }
      @operators << ::Formulator::BinaryOperator.new("ne", 3) { |x, y| x.value != y.value }
      @operators << ::Formulator::BinaryOperator.new("gt", 3) { |x, y| x.value > y.value }
      @operators << ::Formulator::BinaryOperator.new("lt", 3) { |x, y| x.value < y.value }
      @operators << ::Formulator::BinaryOperator.new("ge", 3) { |x, y| x.value >= y.value }
      @operators << ::Formulator::BinaryOperator.new("le", 3) { |x, y| x.value <= y.value }

      # Boolean and/or

      @operators << ::Formulator::BinaryOperator.new("and", 2) { |x, y| x.value && y.value }
      @operators << ::Formulator::BinaryOperator.new("or", 2) { |x, y| x.value || y.value }

      # Logical not

      @operators << ::Formulator::UnaryOperator.new("not", 4) { |x| !x.value }

    end
  end
end