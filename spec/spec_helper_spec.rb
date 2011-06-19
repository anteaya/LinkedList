require 'spec_helper'

class DummyClass
  include SpecHelper
end

describe DummyClass do
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(SpecHelper)
  end

  describe "SpecHelper" do
    it "#create_node(values) creates a list of nodes when given an array of values" do
      array = ['dog', 'cat', 'bird', 'fish']
      nodes = @dummy_class.create_node(array)
      nodes.data.should == 'dog'
      nodes.next_node.data.should == 'cat'
      nodes.next_node.next_node.data.should == 'bird'
      nodes.next_node.next_node.next_node.data.should == 'fish'
    end

    it "#check_data(array, list) takes an array and a list and compares their length and values to ensure a match" do
      array = %w/maple oak beech birch/
      list = List.new(@dummy_class.create_node(array))
      @dummy_class.check_data(array, list)
    end
  end
end
