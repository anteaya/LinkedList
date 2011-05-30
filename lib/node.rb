class Node
  attr_accessor :next_node, :data

  def initialize(node_value, next_node = nil)
    @data = node_value
    if next_node.respond_to?(:data) || next_node == nil 
      @next_node = next_node
    else
      raise "The second argument must create a new Node"
    end
  end

  def insert_next(node)
    if next_node.respond_to?(:data)
      pushed_down_node = next_node
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
    removed_node = next_node
    @next_node = next_node.next_node
    removed_node
  end

end
