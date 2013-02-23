require 'formulator/function'
require 'formulator/binary_operator'
require 'formulator/unary_operator'

module Formulator
  module FunctionOperators
    def AddOperators_ArithmeticFunctions
      @operators << ::Formulator::Function.new("sum", 1, nil) do |*args|
        args.inject(0) { |sum, arg| sum + arg.value }
      end

      @operators << ::Formulator::Function.new("max", 1, nil) do |*args|
        max = nil
        args.each { |arg| max = arg.value if !max || arg.value > max }
        max
      end

      @operators << ::Formulator::Function.new("min", 1, nil) do |*args|
        min = nil
        args.each { |arg| min = arg.value if !min || arg.value < min }
        min
      end

      @operators << ::Formulator::Function.new("PI", 0, 0) { Math::PI }
    end

    def AddOperators_BooleanFunctions
      @operators << ::Formulator::Function.new("if", 3, 3) do |cond, x, y|
        cond.value ? x.value : (y.value || 0)
      end
    end
  end
end