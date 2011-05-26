require File.join(File.dirname(__FILE__), 'spec_helper')

describe List do
  include SpecHelper

  context "#swap!" do
    it "takes a list of maximum size 2 and swaps the nodes and returns the original list" do
      node = create_node(['cat'])
      list = List.new(Node.new('horse', node))
      before_id = list.object_id
      list.swap!
      list.beginning_node.object_id.should == node.object_id
      i = 0
      list.each do |x|
        x.data.should == ['cat', 'horse'][i]
        i += 1
      end
      i.should == 2
      list.object_id.should == before_id

      lambda do
        List.new(Node.new('Panama', Node.new('boater', Node.new('veil')))).swap
      end.should raise_error
    end
  end

  context "#split" do
    it "takes a list and returns two new lists" do
      array = %w/pie cake pudding hat coat/
      list = List.new(create_node(array))
      left, right = list.split
      left.should be_an_instance_of(List)
      right.should be_an_instance_of(List)
    end

    it "returns two lists accounting for all the nodes from a list of even size" do
      right_array = ['hat', 'chapeau', 'cap', 'lid']
      node = create_node(right_array)
      left_array = ['bonnet', 'bowler', 'Stetson', 'fedora']
      array = left_array + right_array
      list = List.new(create_node(array))
      left, right = list.split
      i = 0
      left.each do |x|
        x.data.should == left_array[i]
        i += 1
      end
      i.should == 4
      j = 0
      right.each do |x|
        x.data.should == right_array[j]
        j += 1
      end
      j.should == 4
    end

    it "returns two lists accounting for all the nodes from a list of uneven size" do
      left_array = ['wimple', 'shawl', 'babushka']
      right_array = ['miter', 'tiara', 'toque', 'turban']
      node = create_node(right_array)
      list = List.new(Node.new('wimple', Node.new('shawl', Node.new('babushka', node))))
      left, right = list.split
      i = 0
      left.each do |x|
        x.data.should == left_array[i]
        i += 1
      end
      i.should == 3
      j = 0
      right.each do |x|
        x.data.should == right_array[j]
        j += 1
      end
      j.should == 4
    end
  end
end
