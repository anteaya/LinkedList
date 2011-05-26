require File.join(File.dirname(__FILE__), 'node')

class List
  
  def initialize(first_node = nil)
    @first_node = first_node
  end

  def beginning_node
    @first_node		
  end

  def each
    list = self
    evaluated_node = beginning_node
    while evaluated_node.respond_to?(:data)
      yield evaluated_node
      evaluated_node = evaluated_node.the_next
    end
    list
  end

  def size
    list = self
    size = 0
    list.each do |node|
      size += 1
    end
    size
  end

  def first(value)
    list = self
    list.each do |node|
      @node = node
      break if node.data == value
    end
    return @node
  end

  def all(value)
    list = self
    array = []
    list.each do |node|
      if node.data == value
        array << node
      end
    end
    array
  end

# the first node is location 1 (one)
  def locate_node(location)
    cache = self.beginning_node
    (location - 1).times do
      cache = cache.the_next
    end
    cache
  end

  def insert_beginning!(new_beginning)
    if beginning_node.respond_to?(:data)
      pushed_down_node = beginning_node
      @first_node = new_beginning
      new_beginning.next_node = pushed_down_node
    else
      @first_node = new_beginning
    end
  end

  def reduce(location)
    if location.respond_to?(:/) && location <= self.size
      node = locate_node(location)
      new_list = List.new(node)
    else
      raise "reduce needs the location of a node expressed as an integer"
    end
  end

  def remove_beginning!
    removed_beginning = beginning_node
    @first_node = beginning_node.the_next
    removed_beginning
  end

  def remove_end!
    list = self.dup
    location = list.size - 1
    node = locate_node(location)
    node.remove_next
  end

  def truncate_to_end(location)
    list = self.dup
    repeats = (size - location)
    repeats.times do
      remove_end!
    end
    list
  end

  def copy
    duplicate = List.new(Node.new(self.beginning_node.data))
    location = 1
    self.each do |node|
      duplicate.locate_node(location).insert_next(Node.new(node.data))
      location += 1
    end
    duplicate.remove_beginning!
    duplicate
  end

  def split
    list = self
    location = list.size / 2
    list_for_right = list.dup
    list_for_left = list.dup
    right = list_for_right.reduce(location + 1) 
    left = list_for_left.truncate_to_end(location)
    [left, right]
  end

  def swap!
    list = self
    if list.size == 2
      new_beginning = list.beginning_node.the_next
      list.remove_end!
      list.insert_beginning!(new_beginning)
    elsif list.size < 2
      list
    else
      raise "The swap method only works for lists with two nodes."
    end
  end

 
end
