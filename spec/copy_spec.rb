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
    
    it "takes a list and returns a copy that has the same node values in the same relationship as the original" do
      colours = %w/tan magenta cyan tangerine violet poppy/
      list = List.new(create_node(colours))
      copied_list = list.copy
      i = 0
      copied_list.each do |node|
        node.data.should == colours[i]
        i += 1
      end
      i.should == list.size
    end
  end
end
