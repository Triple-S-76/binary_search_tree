require 'pry-byebug'

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    if array.instance_of?(Array)
      array_sorted_uniq = array.sort.uniq
      @root = build_tree(array_sorted_uniq)
    else
      @root = build_tree(array)
    end
  end

  def build_tree(array)
    return Node.new(array) unless array.instance_of?(Array)
    return if array.empty?

    index_mid = array.length / 2
    new_node = Node.new(array[index_mid])

    new_node.left = build_tree(array[0...index_mid])
    new_node.right = build_tree(array[index_mid + 1..])

    new_node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
