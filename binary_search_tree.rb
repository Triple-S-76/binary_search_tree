# frozen_string_literal: true

# This class creates nodes
class Node
  attr_accessor :data, :left, :right, :total

  @@total = 0

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
    @@total += 1
    # p "Total nodes created: #{@@total}"
  end
end

# This class creates the entire tree
class Tree
  attr_reader :root

  def initialize(array = [])
    # p "this is the original array: #{array}"
    if array.empty?
      @root = Node.new(nil)
    else
      @root = build_tree(array, 0, array.length - 1)
    end
  end

  def build_tree(array, index_start, index_end)
    return nil if index_start > index_end

    index_middle = (index_start + index_end) / 2
    node = Node.new(array[index_middle])

    index_left_end = index_middle - 1
    index_right_start = index_middle + 1

    node.left = build_tree(array, index_start, index_left_end)
    node.right = build_tree(array, index_right_start, index_end)

    node
  end

  def find(element, node = root)
    return "'#{element}' is invalid" unless element.is_a?(Numeric)

    return "#{element} is not in the tree" if node.nil? || node.data.nil?

    if element == node.data
      "#{element} is in the tree"
    elsif element < node.data
      find(element, node.left)
    else
      find(element, node.right)
    end
  end

  def insert(element, node = root)
    return "'#{element}' is invalid" unless element.is_a?(Numeric)

    if element == node.data
      return "#{element} is already in the tree"
    elsif root.data.nil?
      new_root = Node.new(element)
      return @root = new_root
    end

    if element < node.data
      insert_on_side(element, node, node.left, 'left')
    else
      insert_on_side(element, node, node.right, 'right')
    end
  end

  def insert_on_side(element, node, side_node, side)
    if side_node.nil?
      insert_node(element, node, side)
    else
      insert(element, side_node)
    end
  end

  def insert_node(element, node, side)
    new_node = Node.new(element)
    if side == 'left'
      node.left = new_node
    else
      node.right = new_node
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
