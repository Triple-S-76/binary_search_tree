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

  def initialize(array)
    p "this is the original array: #{array}"
    @root = build_tree(array, 0, array.length - 1)
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
    direction = find_direction(element, node)
    find_element(element, node, direction)
  end

  def find_direction(element, node)
    if node.data == element
      'match'
    elsif node.data.nil?
      answer 'nil'
    elsif element < node.data
      'left'
    else
      'right'
    end
  end

  def find_element(element, node, direction)
    case direction
    when 'match'
      true
    when 'nil'
      false
    when 'left'
      return "#{element} is not in the tree" if node.left.nil?

      find(element, node.left)
    when 'right'
      return "#{element} is not in the tree" if node.right.nil?

      find(element, node.right)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
