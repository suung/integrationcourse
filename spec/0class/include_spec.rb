require 'spec_helper'

module A
  def my_extension
    puts "extension"
  end
end
class B
end

describe B do
  subject { B.new }
  context "without including A" do
    it "should not respond to '#my_extension'" do
      expect(subject).to_not respond_to(:my_extension)
    end
  end

  context "after including A" do
    before { B.send :include, A }
    it "should respond to '#my_extension'" do
      expect(subject).to respond_to(:my_extension)
    end
  end
end
