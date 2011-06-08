require File.join(File.dirname(__FILE__), 'spec_helper')

describe List do
  include SpecHelper

  array = []
  i = 0
  check_data = lambda {|x| x.data.should == array[i]; i += 1} 
  
  context "#new" do
    it "initialzes" do
      list = List.new
      list.first_node.should == nil
    end

    it "takes a node and returns a list" do
      node = Node.new('telephone')
      list = List.new(node)
      list.should be_an_instance_of(List)
    end
  end

  context "#beginning_node" do
    it "is nil if empty" do
      list = List.new
      list.first_node == nil
    end

    it "takes a list and returns the beginning node" do
      list = List.new(create_node(%w/lemon/))
      list.first_node.should be_an_instance_of(Node)
      list.first_node.data == 'lemon'
    end
  end

  it "#each takes a list and returns the same list" do
   array = %w/cherimoya avocado soursop persimmion citron/
   list = List.new(create_node(array))
   before_id = list.object_id
   i = 0
   list.each &check_data 
   i.should == 5
   list.object_id.should == before_id
  end

  context "#size" do
    it "takes a list and returns an integer(Fixnum)" do
      list = List.new(create_node(%w/maple oak hemlock beech/))
      return_value = list.size
      return_value.should be_an_instance_of(Fixnum)
    end
    it "returns 0 for a List with no nodes" do
      list = List.new
      list.size.should == 0
    end

    it "returns 1 for a List with one node" do
      list = List.new(create_node(['raspberry']))
      list.size.should == 1
    end

    it "returns 5 for a List with five nodes" do
      list = List.new(create_node(%w/lychee coconut fig pomegranate loquat/)) 
      list.size.should == 5
    end
  end
  
  context "#insert_beginning!" do
    it "takes a list with an argument(node) and returns the node passed in as an argument" do
      list = List.new
      return_value = list.insert_beginning!(create_node(['hollyhock']))
      return_value.should be_an_instance_of(Node)
      return_value.data.should == 'hollyhock'
    end
    it "inserts a beginning into a list without a beginning" do
      list = List.new
      list.insert_beginning!(create_node(['grapefruit']))
      list.first_node.data.should == 'grapefruit'
    end

    it "inserts a new beginning into a list with a beginning" do
      list = List.new(create_node(['apricot']))
      list.insert_beginning!(create_node(['kumquat']))
      list.first_node.data.should == 'kumquat'
      list.first_node.next_node.data.should == 'apricot'
    end
  end

  context "#reduce" do
    it "duplicates a list and returns a smaller version, beginning with a specific location in the list" do
      array = %w/carrot tomato celery spinach/
      node = create_node(array)
      list = List.new(Node.new('eggplant', Node.new('beans', Node.new('peas', Node.new('potato', node)))))
      before_id = list.object_id
      reduced_list = list.reduce(5)
      i = 0
      reduced_list.each &check_data
      i.should == 4
      reduced_list.object_id.should_not == before_id
    end

    it "throws an error is argument is not an integer or if integer doesn't correspond to a node in the list" do
      list = List.new(Node.new('plum', Node.new('prune', Node.new('raisin'))))
      lambda do
        list.reduce('apple')
      end.should raise_error("reduce needs the location of a node expressed as an integer")

      lambda do
        list.reduce(6)
      end.should raise_error("reduce needs the location of a node expressed as an integer")
    end
  end

  context "#remove_beginning!" do
    it "takes a list and returns the removed node" do
      list = List.new(create_node(%w/tulip lilac daffodil/))
      return_value = list.remove_beginning!
      return_value.should be_an_instance_of(Node)
      return_value.data.should == 'tulip'
    end

    it "from List with one node" do
      list = List.new(create_node(['watermelon']))
      list.remove_beginning!
      list.first_node.should == nil
    end

    it "from List with more than one node" do
      list = List.new(create_node(['strawberry', 'lime']))
      list.remove_beginning!
      list.first_node.data.should == 'lime'
    end
  end

  context "#remove_end!" do
    it "takes a list and returns the removed node" do
      list = List.new(create_node(%w/rose sorrel shrub/))
      return_value = list.remove_end!
      return_value.should be_an_instance_of(Node)
      return_value.data.should == 'shrub'
    end

    it "removes the node at the end of the list" do
      array = %w/almond walnut peanut pecan hazelnut/  
      list = List.new(create_node(array))
      list.remove_end!
      i = 0
      list.each &check_data
      i.should == 4
    end

  end

  context "#truncate_to_end" do
    it "takes a list with a location argument, duplicates the list, removes the remaining nodes and returns the duplicate list" do
      array = %w/red orange yellow green blue indigo violet/
      list = List.new(create_node(array))
      before_id = list.object_id
      returned_list = list.truncate_to_end(3)
      i = 0
      list.each &check_data
      i.should == 3
      returned_list.object_id.should_not == before_id
    end
  end
end
