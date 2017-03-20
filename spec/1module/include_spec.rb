require 'spec_helper'

module E
  def my_extension
    puts "extension"
  end
end
module F
end
class G
end

describe G do
  subject { G.new }

  context "after including F into G" do
    before { G.send :include, F }

    context "without including E into F" do
      it "should not respond to '#my_extension'" do
        expect(subject).to_not respond_to(:my_extension)
      end
    end

    context "after including E into F" do
      before { F.send :include, E }
      before { G.send :include, F }

      it "should respond to '#my_extension'" do
        expect(subject).to respond_to(:my_extension)
      end
    end
  end
end
