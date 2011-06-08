require File.join(File.dirname(__FILE__), 'spec_helper')

describe List do
  include SpecHelper

  array = []
  i = 0
  check_data = lambda {|x| x.data.should == array[i]; i += 1} 

  context "#swap!" do
    it "takes a list of maximum size 2 and swaps the nodes and returns the original list" do
      node = create_node(['cat'])
      list = List.new(Node.new('horse', node))
      before_id = list.object_id
      list.swap!
      list.first_node.object_id.should == node.object_id
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

  context "#merge" do
    it "takes two lists and returns one list" do
      left = List.new(Node.new(8))
      right = List.new(Node.new(4))
      merged_list = List.new.merge(left, right)
      merged_list.should be_an_instance_of(List)
    end

    it "takes the data from the nodes in the two lists and returns a list with sorted data" do
      left = List.new(Node.new(5))
      right = List.new(Node.new(2))
      array = [2, 5]
      merged_list = List.new.merge(left, right)
      i = 0
      merged_list.each &check_data
      i.should == 2
    end
  end
  
  context "#sort" do
    it "takes a list and returns a different list" do
      list = List.new(Node.new('fizzingwhizzby'))
      before_id = list.object_id
      sorted_list = list.sort
      sorted_list.object_id.should_not == before_id
    end

    it "sorts a list with one node" do
      list = List.new(Node.new('the first element'))
      sorted_list = list.sort
      sorted_list.should be_an_instance_of(List)
      sorted_list.first_node.data.should == 'the first element'
    end

    it "sorts a list with two nodes" do
      two_nodes = [4, 2]
      array = [2, 4]
      list = List.new(create_node(two_nodes))
      sorted_list = list.sort
      i = 0
      sorted_list.each &check_data
      i.should == 2
    end

    it "sorts a list with 3 nodes" do
      three_nodes = [6, 4, 2]
      array = [2, 4, 6]
      list = List.new(create_node(three_nodes))
      sorted_list = list.sort
      i = 0
      sorted_list.each &check_data
      i.should == 3
    end

    it "sorts a list with 4 nodes" do
      four_nodes = [45, 101, 3, 76]
      array = [3, 45, 76, 101]
      list = List.new(create_node(four_nodes))
      sorted_list = list.sort
      i = 0
      sorted_list.each &check_data
      i.should == 4
    end

    it "sorts a list with 5 nodes" do
      five_nodes = [78, 99, 2, 8, 5]
      array = [2, 5, 8, 78, 99]
      list = List.new(create_node(five_nodes))
      sorted_list = list.sort
      i = 0
      sorted_list.each &check_data
      i.should == 5
    end

    it "sorts a list with 13 nodes" do
      thirteen_nodes = [9, 99, 555, 44, 5, 103, 102, 104, 78, 101, 45, 67, 34]
      array = [5, 9, 34, 44, 45, 67, 78, 99, 101, 102, 103, 104, 555]
      list = List.new(create_node(thirteen_nodes))
      sorted_list = list.sort
      i = 0
      sorted_list.each &check_data
      i.should == 13
    end
  end

end
