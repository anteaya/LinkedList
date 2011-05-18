class Node
  attr_accessor :next_node

  def initialize(node_value, next_node = nil)
    @node_value = node_value
    if next_node.respond_to?(:data) || next_node == nil 
      @next_node = next_node
    else
      raise "The second argument must create a new Node"
    end
  end

  def data
    @node_value
  end

  def the_next
    @next_node
  end

  def insert_next(node)
    if the_next.respond_to?(:data)
      pushed_down_node = the_next
      @next_node = node
      node.insert_next(pushed_down_node)
      node
    elsif node.respond_to?(:data)
      @next_node = node
    else
      raise "You have to pass in a instance of Node as an argument"
    end
  end

  def remove_next
    removed_node = the_next
    @next_node = the_next.the_next
    removed_node
  end

end
