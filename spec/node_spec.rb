require File.join(File.dirname(__FILE__), 'spec_helper')

describe Node do
  include SpecHelper

  context "#new" do
    it "initializes a new Node object with an argument(string or integer) and returns a node" do
      node_with_string_value = Node.new('string')
      node_with_integer_value = Node.new(78)
      node_with_string_value.should be_an_instance_of(Node)
      node_with_integer_value.should be_an_instance_of(Node)
    end
    
    it "when given one argument, next_node defaults to nil" do
      node = Node.new('yarn')
      node.data.should == 'yarn'
      node.next_node.should == nil
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

  it "#data takes a node and returns a string or integer(Fixnum)" do
    node = create_node(['date'])
    integer_node = create_node([56])
    node.data.should be_an_instance_of(String)
    node.data.should == 'date'
    integer_node.data.should be_an_instance_of(Fixnum)
    integer_node.data.should == 56
  end

  it "#the_next takes a node and returns the following node" do
    node = create_node(['apple', 'orange'])
    node.next_node.should be_an_instance_of(Node)
    node.data.should == 'apple'
    node.next_node.data.should == 'orange'
  end

  context "#insert_next" do
    it "takes a node with argument(node) and returns the node that was passed in as an argument" do
      node = create_node(['guava'])
      return_value = node.insert_next(Node.new('chokecherry'))
      return_value.should be_an_instance_of(Node)
      return_value.data.should == 'chokecherry'
      integer_node = create_node([47])
      integer_return_value = integer_node.insert_next(Node.new(90))
      integer_return_value.should be_an_instance_of(Node)
      integer_return_value.data.should == 90
    end

    it "has the correct value for new node" do
      node = create_node(['papaya'])
      node.insert_next(Node.new('pear')).should be_an_instance_of(Node)
      node.next_node.data.should == 'pear'
    end

    it "inserts a node between two nodes" do
      node = create_node(['papaya', 'quince'])
      node.insert_next(Node.new('rhubarb'))
      node.next_node.next_node.data.should == 'quince'
    end

    it "raises an error when the argument is not an instance of Node" do
     lambda do
        Node.new('plum').insert_next('shoe')
      end.should raise_error
    end
  end

  context "#remove_next" do
    it "takes a node and returns the removed node" do
      node = create_node(['pumpkin', 'squash'])
      return_value = node.remove_next
      return_value.should be_an_instance_of(Node)
      return_value.data.should == 'squash'
    end

    it "removes the node following the reciever" do
      node = create_node(['starfruit', 'elderberry', 'gooseberry', 'cranberry'])
      node.data.should == 'starfruit'
      node.next_node.data.should == 'elderberry'
      node.remove_next
      node.next_node.data.should == 'gooseberry'
    end
  end
end
