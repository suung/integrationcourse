require 'spec_helper'

module C
  def my_extension
    puts "extension"
  end
end
class D
end

describe D do
  subject { D }
  context "without extending from C" do
    it "should not respond to '#my_extension'" do
      expect(subject).to_not respond_to(:my_extension)
    end
  end

  context "after extending from C" do
    before { D.send :extend, C }
    it "should respond to '#my_extension'" do
      expect(subject).to respond_to(:my_extension)
    end
  end
end
