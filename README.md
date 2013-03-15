# RCalc

RCalc is gem which can help you adding calculator like behaviour to your code. It is sandboxed and there is no posibility that end user can execute some code against your system.

## Installation

Add this line to your application's Gemfile:

    gem 'r_calc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install r_calc

## Usage

To use this gem, after including this could be minimum of required code to run calculation:

```ruby
require 'r_calc'

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

end
```

After you customizaed your calculator, next in your code you can inicialize it and use it like below:
```ruby
# storing [var,values] pair in hash
values = Hash.new
# make instance of your calculator
calc = Calculator.new do |key, val|
  values[key] = val if val
  values[key]
end

calc.eval("var1 = 12 * 12")
calc.eval("var2 = 100 * 2")

puts "total is = #{calc.eval("sum(var1, var2)")}"
# output should be: 
# total is = 344

```

Don't worry about eval, it is not evail :) the method is overwriten in parent class and will use lexical parser to build formula bevore execute it. So in case you write:

```ruby
# try to call unix ls command
calc.eval("system('ls')")

```

It will throw error since token is not recognised. Of course, you can implement custom gramar and include it in your calculator so it reconise system token as some function which assepts numbers and do some neath calculation


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
