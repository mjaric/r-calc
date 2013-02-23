# encoding: utf-8
require 'spec_helper'

describe Formulator::FormulaProcessor do

  RSpec.configure do |c|
    c.include FormulatorHelpers
  end


  describe "#eval" do
    it "can add two numbers" do
      calculator.eval("2+2").should eq(4)
    end
    it "can multiple two numbers" do
      calculator.eval("2*2").should eq(4)
    end
    it "can divide two numbers" do
      calculator.eval("2/2").should eq(1)
    end
    it "can mod (%) two numbers" do
      calculator.eval("3%2").should eq(1)
    end
    it "can pow (^) two numbers" do
      calculator.eval("3^2").should eq(9)
    end
    it "can sum more than 2 numbers" do
      calculator.eval("sum(1,2,3,4,5)").should eq(15)
    end
    it "can get minimum of number sequence" do
      calculator.eval("min(1,2,3,4,5)").should eq(1)
    end
    it "can get maximum of number sequence" do
      calculator.eval("max(1,2,3,4,5)").should eq(5)
    end
    it "can compare numbers" do
      calculator.eval("4 lt 2").should eq(false)
      calculator.eval("4 lt 4").should eq(false)
      calculator.eval("4 lt 5").should eq(true)

      calculator.eval("4 le 2").should eq(false)
      calculator.eval("4 le 4").should eq(true)
      calculator.eval("4 le 5").should eq(true)

      calculator.eval("4 gt 2").should eq(true)
      calculator.eval("4 gt 4").should eq(false)
      calculator.eval("4 gt 5").should eq(false)

      calculator.eval("4 ge 2").should eq(true)
      calculator.eval("4 ge 4").should eq(true)
      calculator.eval("4 ge 5").should eq(false)

      calculator.eval("4 eq 2").should eq(false)
      calculator.eval("4 eq 4").should eq(true)
      calculator.eval("4 eq 5").should eq(false)

      calculator.eval("4 ne 2").should eq(true)
      calculator.eval("4 ne 4").should eq(false)
      calculator.eval("4 ne 5").should eq(true)

    end
    it "can compare numbers using if statement with two branches" do
      calculator.eval("if(4 lt 2, 1, -1 )").should eq(-1)
    end
  end
end