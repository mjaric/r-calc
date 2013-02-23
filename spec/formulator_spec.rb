# encoding: utf-8
require 'spec/spec_helper'

describe Formulator::FormulaProcessor do

  RSpec.configure do |c|
    c.include FormulatorHelpers
  end

  let :c do
    a, b= calculator
    a
  end

  describe "#eval" do
    it "can add two numbers" do
      c.eval("2+2").should eq(4)
    end
    it "can multiple two numbers" do
      c.eval("2*2").should eq(4)
    end
    it "can divide two numbers" do
      c.eval("2/2").should eq(1)
    end
    it "can mod (%) two numbers" do
      c.eval("3%2").should eq(1)
    end
    it "can pow (^) two numbers" do
      c.eval("3^2").should eq(9)
    end
    it "can sum more than 2 numbers" do
      c.eval("sum(1,2,3,4,5)").should eq(15)
    end
    it "can get minimum of number sequence" do
      c.eval("min(1,2,3,4,5)").should eq(1)
    end
    it "can get maximum of number sequence" do
      c.eval("max(1,2,3,4,5)").should eq(5)
    end
    it "can compare numbers" do
      c.eval("4 lt 2").should eq(false)
      c.eval("4 lt 4").should eq(false)
      c.eval("4 lt 5").should eq(true)

      c.eval("4 le 2").should eq(false)
      c.eval("4 le 4").should eq(true)
      c.eval("4 le 5").should eq(true)

      c.eval("4 gt 2").should eq(true)
      c.eval("4 gt 4").should eq(false)
      c.eval("4 gt 5").should eq(false)

      c.eval("4 ge 2").should eq(true)
      c.eval("4 ge 4").should eq(true)
      c.eval("4 ge 5").should eq(false)

      c.eval("4 eq 2").should eq(false)
      c.eval("4 eq 4").should eq(true)
      c.eval("4 eq 5").should eq(false)

      c.eval("4 ne 2").should eq(true)
      c.eval("4 ne 4").should eq(false)
      c.eval("4 ne 5").should eq(true)

    end

    it "can compare numbers using if statement with two branches" do
      c.eval("if(4 lt 2, 1, -1 )").should eq(-1)
    end

  end

  describe "memoizable #eval" do
    it "can memoize variables into the hash" do
      calc, memo = calculator
      calc.eval("number=12*3").should eq(36)
      memo["number"].should eq(36)
    end

    it "can memoize last value sing $" do
      calc, memo = calculator
      val = calc.eval("12*3")
      calc.eval("$").should eq(36)
    end
  end
end