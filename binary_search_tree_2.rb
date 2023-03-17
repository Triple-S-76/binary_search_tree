require 'pry-byebug'

# the class Node creates all the nodes
class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# the class Tree creates and manages the tree
class Tree
  attr_reader :root

  def initialize
    p 'The tree has been initialized'
    puts
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def build_tree(data)
    return p 'I AM ERROR:  The build tree method needs some data' if data.nil?

    if data.instance_of?(Array)
      sorted_uniq_array = data.uniq.sort
      @root = build_tree_array(sorted_uniq_array)
    else
      @root = Node.new(data)
    end
  end

  def build_tree_array(array, index_start = 0, index_end = array.length - 1)
    return if index_start > index_end

    index_middle = (index_start + index_end) / 2
    new_node = Node.new(array[index_middle])
    new_node.left = build_tree_array(array, index_start, index_middle - 1)
    new_node.right = build_tree_array(array, index_middle + 1, index_end)

    new_node
  end

  def insert(data, current_node = root)
    return p "#{data} is already in the tree" if data == current_node.data

    if data < current_node.data
      return current_node.left = Node.new(data) if current_node.left.nil?

      insert(data, current_node.left)
    else # if data > current_node.data
      return current_node.right = Node.new(data) if current_node.right.nil?

      insert(data, current_node.right)
    end
  end

  def delete
    # delete
  end

  def find(data, current_node = root)
    return p "#{data} is not in the tree" if current_node.nil?

    if data < current_node.data
      find(data, current_node.left)
    elsif data > current_node.data
      find(data, current_node.right)
    else
      p "Found #{data} in the tree"
      current_node
    end
  end

  def level_order_recursive(current_node = root, queue = [], array = [])
    current_node = find(current_node) if current_node.class != Node
    return if current_node.data.nil?

    array << current_node.data unless current_node.nil?
    queue << current_node.left unless current_node.left.nil?
    queue << current_node.right unless current_node.right.nil?

    return array if queue.empty?

    next_node = queue.shift
    level_order_recursive(next_node, queue, array)
  end

  def level_order_loop(current_node = root)
    current_node = find(current_node) if current_node.class != Node

    array = []
    queue = [current_node]

    until queue.empty?
      current_node = queue.shift
      array << current_node.data
      queue << current_node.left unless current_node.left.nil?
      queue << current_node.right unless current_node.right.nil?
    end
    array
  end
end

