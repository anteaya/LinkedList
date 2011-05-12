require 'rspec'
require File.join(File.dirname(__FILE__), '..','lib', 'sort')

#3) sort a list
#       1) each of the nodes in the List will have a number (n > 0 < n)
#       2) this method will re-order a copy of the list
#       3) hint => use message 'dup' to make a copy of an object


describe Sort do

  it "creates a duplicate of a List" do
    sort = Sort.new(List.new(Node.new('shoes', Node.new('socks', Node.new('pants', Node.new('belt', Node.new('shirt', Node.new('tie', Node.new('jacket')))))))))
    
  end

end
