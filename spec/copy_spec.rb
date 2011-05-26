require File.join(File.dirname(__FILE__), 'spec_helper')

describe List do
  include SpecHelper

  context "#copy" do
    it "takes a list and returns a new list" do
      animals = %w/mouse moose horse/
      list = List.new(create_node(animals))
      before_id = list.object_id
      copied_list = list.copy
      copied_list.should be_an_instance_of(List)
      copied_list.object_id.should_not == before_id
    end

    it "takes a list and returns a copy that has the same length as the original" do
      plants = %w/fern tree shrub flower weed grass/
      list = List.new(create_node(plants))
      list_length = list.size
      copied_list = list.copy
      copied_list.size.should == list_length
    end
  end
end
