require File.join(File.dirname(__FILE__), 'node')

class List
  attr_accessor :first_node
  
  def initialize(first_node = nil)
    @first_node = first_node
  end

  def each
    list = self
    evaluated_node = first_node
    while evaluated_node.respond_to?(:data)
      yield evaluated_node
      evaluated_node = evaluated_node.next_node
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
    list = self
    cache = list.first_node
    (location - 1).times do
      cache = cache.next_node
    end
    cache
  end

  def insert_beginning!(new_beginning)
    if first_node.respond_to?(:data)
      pushed_down_node = first_node
      @first_node = new_beginning
      new_beginning.next_node = pushed_down_node
    else
      @first_node = new_beginning
    end
  end

  def reduce(location)
    list = self
    if location.respond_to?(:/) && location <= list.size
      node = locate_node(location)
      new_list = List.new(node)
    else
      raise "reduce needs the location of a node expressed as an integer"
    end
  end

  def remove_beginning!
    removed_beginning = first_node
    @first_node = first_node.next_node
    removed_beginning
  end

  def remove_end!
    list = self.copy
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
    list = self
    duplicate = List.new(Node.new(list.first_node.data))
    location = 1
    list.each do |node|
      duplicate.locate_node(location).insert_next(Node.new(node.data))
      location += 1
    end
    duplicate.remove_beginning!
    duplicate
  end

  def split
    list = self
    location = list.size / 2
    list_for_right = list.copy
    list_for_left = list.copy
    right = list_for_right.reduce(location + 1) 
    left = list_for_left.truncate_to_end(location)
    [left, right]
  end

  def swap!
    list = self
    if list.size == 2
      new_beginning = list.first_node.next_node
      list.remove_end!
      list.insert_beginning!(new_beginning)
    elsif list.size < 2
      list
    else
      raise "The swap method only works for lists with two nodes."
    end
  end

  def merge(left, right)
    result = List.new
    while left.size != 0 || right.size != 0
      if left.first_node.respond_to?(:data) && right.first_node.respond_to?(:data) && left.first_node.data < right.first_node.data || right.size == 0
        if result.first_node == nil
          result.first_node = Node.new(left.first_node.data)
          left.remove_beginning!
        else
          result.locate_node(result.size).insert_next(Node.new(left.first_node.data))
          left.remove_beginning!
        end
        if left.size == 0 && right.size == 0
          break
        end
      else
        if result.first_node == nil
          result.first_node = Node.new(right.first_node.data)
          right.remove_beginning!
        else
          result.locate_node(result.size).insert_next(Node.new(right.first_node.data))
          right.remove_beginning!
        end
        if left.size == 0 && right.size == 0
          break
        end
      end
    end
    result
  end
  
  def sort
    list = self.copy
    if list.size < 2
      list
    else
     left, right = list.split
     left = left.sort
     right = right.sort
     result = merge(left, right)
    end
  end
 
end
