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
    include ::Formulator::FunctionOperators # sum(), max(), min()
    # example of adding custom operators

    def AddOperators_custom

      calc = self


      # Now let's show how you can use a function to access a constant, like PI

      @operators << ::Formulator::BinaryOperator.new("[", 3) {|x, y| x.value + y.value}
      @operators << ::Formulator::UnaryOperator.new("]", 4) { |x| x.value }

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