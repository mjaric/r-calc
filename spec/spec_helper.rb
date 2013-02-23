require 'formulator'
#require 'supermodel'
#require 'minitest/spec'
#require 'minitest/autorun'

module FormulatorHelpers
  class Calculator < Formulator::FormulaProcessor
    # Let's just add all of the usual operators

    include ::Formulator::ParentheticalGrouping # ()
    include ::Formulator::AssignmentOperator # =
    include ::Formulator::LastResultOperator # $
    include ::Formulator::ArithmeticOperators # +-*/%^
    include ::Formulator::BooleanOperators # true false and or eq ne gt lt ge le not

    # example of adding custom operators

    def AddOperators_custom

      calc = self

      # Just for fun, let's define a "sum" function, that can take 1 or more
      # arguments and return their sum

      @operators << ::Formulator::Function.new("sum", 1, nil) do |*args|
        args.inject(0) { |sum, arg| sum + arg.value }
      end

      # Now let's show how you can use a function to access a constant, like PI
      @operators << ::Formulator::Function.new("PI", 0, 0) { Math::PI }
      @operators << ::Formulator::BinaryOperator.new("[", 3) {|x, y| x.value + y.value}
      @operators << ::Formulator::UnaryOperator.new("]", 4) { |x| x.value }
      # Here are some functions that take arguments

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

      @operators << ::Formulator::Function.new("if", 3, 3) do |cond, x, y|
        val = 0
        val = cond.value ? x.value : (y.value || 0)
        val
      end
    end
  end

  def calculator


    values = Hash.new
    calc = Calculator.new do |key, val|
      values[key] = val if val
      values[key]
    end
    [calc, values]
  end

end