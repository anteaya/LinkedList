require 'spec_helper'

class DummyClass
  include SpecHelper
end

describe DummyClass do
  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(SpecHelper)
  end


  it "creates a list of nodes when given an array of values" do
    array = ['dog', 'cat', 'bird', 'fish']
    nodes = @dummy_class.create_node(array)
    nodes.data.should == 'dog'
    nodes.next_node.data.should == 'cat'
    nodes.next_node.next_node.data.should == 'bird'
    nodes.next_node.next_node.next_node.data.should == 'fish'
  end
end
