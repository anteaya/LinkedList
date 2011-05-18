require File.join(File.dirname(__FILE__), 'spec_helper')

describe Node do
  include SpecHelper

  context "#new" do
    it "takes a string or integer and returns a Node" do
      node_with_string_value = Node.new('string')
      node_with_integer_value = Node.new(78)
      node_with_string_value.should be_an_instance_of(Node)
      node_with_integer_value.should be_an_instance_of(Node)
    end
    
    it "when given one argument, next_node defaults to nil" do
      node = Node.new('yarn')
      node.data.should == 'yarn'
      node.the_next.should == nil
    end

    it "node takes data and next_node" do
      lambda do
        Node.new('plum', 'not_a_node')
      end.should raise_error

      lambda do
        Node.new('cherry', Node.new('blackberry'))
      end.should_not raise_error
    end
  end

  it "#data should take a Node and return a string or integer(Fixnum)" do
    node = create_node(['date'])
    integer_node = create_node([56])
    node.data.should be_an_instance_of(String)
    node.data.should == 'date'
    integer_node.data.should be_an_instance_of(Fixnum)
    integer_node.data.should == 56
  end

  it "#the_next takes an instance of Node and returns an instance of Node" do
    node = create_node(['apple', 'orange'])
    node.the_next.should be_an_instance_of(Node)
  end

  context "#insert_next" do
    it "takes a string or an integer and returns an instance of Node" do
      node = create_node(['guava'])
      node.insert_next('chokecherry').should be_an_instance_of(Node)
      integer_node = create_node([47])
      integer_node.insert_next(90).should be_an_instance_of(Node)
    end

    it "has the correct value for new node" do
      node = create_node(['papaya'])
      node.insert_next('pear').should be_an_instance_of(Node)
      node.the_next.data.should == 'pear'
    end

    it "inserts a node between two nodes" do
      node = create_node(['papaya', 'quince'])
      node.insert_next('rhubarb')
      node.the_next.the_next.data.should == 'quince' 
    end
  end

  context "#remove_next" do
    it "takes an instance of Node and returns an instance of Node" do
      node = create_node(['pumpkin', 'squash'])
      node.remove_next.should be_an_instance_of(Node)
    end
    it "removes next" do
      node = create_node(['starfruit', 'elderberry', 'gooseberry', 'cranberry'])
      node.remove_next.data.should == 'elderberry'
      node.the_next.data.should == 'gooseberry'
    end
  end
end
