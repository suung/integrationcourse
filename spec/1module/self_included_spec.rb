require 'spec_helper'

module H
  def my_extension
    "extension"
  end
end
module I
  def self.included(base)
    base.class_eval do
      define_method(:my_extension) { "hacked extension"}
      def my_other_extension
        "other extension"
      end
    end
    base.instance_eval do
      def my_extension
        "powned extension"
      end
    end
  end
end
class J
end

describe J do
  subject { J.new }
  context "after including H into J" do
    before { J.send :include, H }

    specify "#my_extension returns 'extension'" do
      expect(subject.my_extension).to eq "extension"
    end

    context "after including I into J aswell" do
      before { J.send :include, I }

      specify "#my_extension has been overridden and returns 'hacked extension'" do
        expect(subject.my_extension).to eq 'hacked extension'
      end
      specify "J.my_extension has been defined and returns 'powned extension'" do
        expect(J.my_extension).to eq 'powned extension'
      end
    end
  end
end
