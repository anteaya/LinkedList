require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'node')
require File.join(File.dirname(__FILE__), '..', 'lib', 'list')

module SpecHelper

  def create_node(values)
    values = values.dup
    nodes = nil
    while values.length != 0
      nodes = Node.new(values.last, nodes)
      values.pop
    end
    nodes
  end
  
  array = []
  i = 0
  check_data = lambda {|x| x.data.should == array[i]; i += 1}

end
