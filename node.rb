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

  def next
    @next_node
  end

  def insert_next(node)
    if self.next.respond_to?(:data)
      pushed_down_node = self.next
      @next_node = Node.new(node, pushed_down_node)
    else
      @next_node = Node.new(node)
    end
  end

  def remove_next
    removed_node = self.next
    @next_node = self.next.next
    removed_node
  end

end
