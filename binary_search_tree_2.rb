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

  def preorder_recursive(current_node = root, array = [])
    return if current_node.nil?

    current_node = find(current_node) if current_node.class != Node
    unless current_node.nil?
      array << current_node.data
      preorder_recursive(current_node.left, array)
      preorder_recursive(current_node.right, array)
    end
    array
  end

  def preorder_loop(starting_node = root)
    return 'The tree is empty' if starting_node.nil?

    starting_node = find(starting_node) if starting_node.class != Node
    array = []
    stack = [starting_node]

    until stack.empty?
      current_node = stack.pop
      array << current_node.data
      stack << current_node.right unless current_node.right.nil?
      stack << current_node.left unless current_node.left.nil?
    end
    array
  end

  def inorder_recursive(current_node = root, array = [])
    return if current_node.nil?

    current_node = find(current_node) if current_node.class != Node

    inorder_recursive(current_node.left, array) unless current_node.left.nil?
    array << current_node.data
    inorder_recursive(current_node.right, array) unless current_node.right.nil?
    array
  end

  def inorder_loop(starting_node = root)
    return 'The tree is empty' if starting_node.nil?

    starting_node = find(starting_node) if starting_node.class != Node
    array = []
    stack = []
    current_node = starting_node

    while current_node || !stack.empty?
      while current_node
        stack << current_node
        current_node = current_node.left
      end
      current_node = stack.pop
      array << current_node.data
      current_node = current_node.right
    end
    array
  end

  def inorder_loop2(starting_node = root)
    starting_node = find(starting_node) if starting_node.class != Node
    current_node = starting_node
    stack = []
    array = []

    until current_node.nil? && stack.empty?
      if current_node.nil?
        current_node = stack.pop
        array << current_node.data
        current_node = current_node.right
      else
        stack << current_node
        current_node = current_node.left
      end
    end
    array
  end

  def postorder_recursive(current_node = root, array = [])
    return if current_node.nil?

    current_node = find(current_node) if current_node.class != Node

    postorder_recursive(current_node.left, array) unless current_node.left.nil?
    postorder_recursive(current_node.right, array) unless current_node.right.nil?
    array << current_node.data
  end
end
