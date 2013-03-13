require 'r_calc'
#require 'supermodel'
#require 'minitest/spec'
#require 'minitest/autorun'

module RCalcHelpers
  class Calculator < RCalc::FormulaProcessor
    # Let's just add all of the usual operators

    include ::RCalc::ParentheticalGrouping # ()
    include ::RCalc::AssignmentOperator # =
    include ::RCalc::LastResultOperator # $
    include ::RCalc::ArithmeticOperators # +-*/%^
    include ::RCalc::BooleanOperators # true false and or eq ne gt lt ge le not
    include ::RCalc::FunctionOperators # sum(), max(), min()
    # example of adding custom operators

    def AddOperators_custom

      calc = self


      # Now let's show how you can use a function to access a constant, like PI

      @operators << ::RCalc::BinaryOperator.new("[", 3) {|x, y| x.value + y.value}
      @operators << ::RCalc::UnaryOperator.new("]", 4) { |x| x.value }

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