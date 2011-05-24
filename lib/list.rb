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
    list = self
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




  def split
    list = self
    location = list.size / 2
    new_list = list.dup
    right = new_list.insert_beginning(location + 1)
    left = new_list.remove_end(location)
    [left, right]
  end

  def swap
    list = self
    if list.size == 2
      new_beginning = list.beginning_node.the_next
      list.remove_end
      list.insert_beginning(new_beginning)
    elsif list.size < 2
      list
    else
      raise "The swap method only works for lists with two nodes."
    end
  end

  def merge(left, right)
    result = List.new
    while left.size != 0 || right.size != 0
      if left.size == 0
        while right.size != 0
          result = result.insert_next(right.beginning_node) && right.remove_beginning
        end
        break
      end
      if right.size == 0
        while left.size != 0
          result = result.insert_next(left.beginning_node) && left.remove_beginning
        end
        break
      end
      if left.beginning_node.data < right.beginning_node.data
        if result.beginning_node == nil
          result = result.insert_beginning(left.beginning_node) && left.remove_beginning
        else
         result = result.insert_next(left.beginning_node) && left.remove_beginning
        end
      else
        if result.beginning_node == nil
          result = result.insert_beginning(right.beginning_node) && right.remove_beginning
        else
          result = result.insert_next(right.beginning_node) && right.remove_beginning
        end
      end
    end
    result  
  end

  def sort
    duplicated_list = self.dup
    list_size = duplicated_list.size
    if list_size < 2
    elsif list_size == 2
      if beginning_node.data > beginning_node.the_next.data
        duplicated_list.swap
      end
    else
      left, right = duplicated_list.split
      left = left.sort
      right = right.sort
      result = merge(left, right)
    end
    duplicated_list
  end
end
