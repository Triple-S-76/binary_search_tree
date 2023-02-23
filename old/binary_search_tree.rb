require 'pry'
# frozen_string_literal: true

# The Node class creates the nodes for the Tree class
class Node
  include Comparable

  attr_accessor :left, :right, :data

  @@total = 0

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
    @@total += 1
    # p "TOTAL NODES: #{@@total}"
  end
end

# The Tree class will create the tree and include all nodes
class Tree
  attr_accessor :root

  def initialize(array)
    # p array.length
    if array.length.zero?
      @root = zero_length_array
    else
      @root = build_tree(array)
    end
  end

  def zero_length_array
    @root = Node.new(nil)
  end

  def build_tree(array, index_start = 0, index_end = array.length - 1)
    return nil if index_start > index_end

    # create main entry
    middle_index = (index_start + index_end) / 2
    new_node = Node.new(array[middle_index])

    # set info for left child
    left_start = index_start
    left_end = middle_index - 1

    # set info for right child
    right_start = middle_index + 1
    right_end = index_end

    new_node.left = build_tree(array, left_start, left_end)

    new_node.right = build_tree(array, right_start, right_end)
    new_node
  end

  def insert(value, node = root)
    return @root.data = value if root.data.nil?

    if value < node.data
      return node.left = Node.new(value) if node.left.nil?

      insert(value, node.left)
    elsif value > node.data
      return node.right = Node.new(value) if node.right.nil?

      insert(value, node.right)
    else
      p "The value: #{value} is already in the tree."
    end
  end

  def delete(value, node = root, previous_node = nil, previous_node_side = nil)
    if value < node.data
      return info_not_in_tree if node.left.nil?

      delete(value, node.left, node, 'left')
    elsif value > node.data
      return info_not_in_tree if node.right.nil?

      delete(value, node.right, node, 'right')
    else
      p "found: #{value}"
      delete_node(node, previous_node, previous_node_side)
    end
  end

  def info_not_in_tree
    p 'ITS NOT HERE!!!'
  end

  def node_to_delete_is_root(node)
    p 'NODE TO DELETE IS ROOT IS RUNNING'
    node_children_info = find_node_children_info(node)
    p node_children_info
    case node_children_info
    when 'no children'
      root.data = nil
    when 'left child'
      p 'there is only a left child'
      node_to_swap = find_the_node_to_swap(node, node_children_info)
      node_to_swap_previous_node = find_the_node_to_swap_previous_node(node, node_children_info, node_to_swap)
      p "node_to_swap_previous_node data: #{node_to_swap_previous_node.data}"
    else
      p 'there is a right child'
      node_to_swap = find_the_node_to_swap(node, node_children_info)
      node_to_swap_previous_node = find_the_node_to_swap_previous_node(node, node_children_info, node_to_swap)
      p "node_to_swap_previous_node data: #{node_to_swap_previous_node.data}"
    end
  end


  def delete_node(node, previous_node, previous_node_side)
    p 'delete_node starting'

    if root == node
      p 'node to delete is root'
      node_to_delete_is_root(node)
    else
      p 'node to delete is NOT root'

      node_children_info = find_node_children_info(node)
      p node_children_info
      puts
  
      return
  
      return node_is_leaf_node(previous_node, previous_node_side) if node_children_info == 'no children'
  
      node_to_swap = find_the_node_to_swap(node, node_children_info)
      p "node_to_swap data: #{node_to_swap.data}"
      puts
      puts
      puts
  
      node_to_swap_previous_node = find_the_node_to_swap_previous_node(node, node_children_info, node_to_swap)
  
      puts
      puts
      puts
      p "node_to_swap_previous_node.data: #{node_to_swap_previous_node.data}"
      # p node_to_swap_previous_node
  
      puts
      puts
      puts
  
      node_to_swap_children = find_node_to_swap_children(node_to_swap)
      p "node_to_swap_children: #{node_to_swap_children}"
  
      puts
      puts
      puts
  
      p "node.data: #{node.data}"
      p "previous_node: #{previous_node}"
      p "previous_node.data: #{previous_node.data}" unless previous_node.nil?
      p "previous_node_side: #{previous_node_side}"
      p "node_to_swap data: #{node_to_swap.data}"
      p "node_to_swap_previous_node.data: #{node_to_swap_previous_node.data}"
      p "node_to_swap_children: #{node_to_swap_children}"
  
      if node_to_swap == root
        p 'node is root'
        delete_root_node(node)
      else
        p 'node is not root'
      end
  
      p 'EXIT'
      return
  
    end


  end

  def node_is_leaf_node(previous_node, previous_node_side)
    if previous_node_side == 'left'
      previous_node.left = nil
    else
      previous_node.right = nil
    end
    return
  end

  def find_node_to_swap_children(node_to_swap)
    if node_to_swap.left.nil? && node_to_swap.right.nil?
      'no children'
    elsif node_to_swap.left.nil?
      'right child'
    else
      'left child'
    end
  end

  def find_the_node_to_swap_previous_node(node, node_children_info, node_to_swap)
    # p 'find_the_node_to_swap_previous_node is running'
    # p "node.data: #{node.data}"
    # p "node_to_swap.data: #{node_to_swap.data}"
    # p "node_children_info: #{node_children_info}"
    # puts

    case node_children_info
    when '2 children' || 'right child'
      p 'THERE IS A RIGHT CHILD'
      return node if node.right.left.nil?

      find_the_node_to_swap_previous_node_helper(node.right, 'left', node_to_swap)
    when 'left child'
      p 'THERE IS ONLY A LEFT CHILD'
      return node if node.left.right.nil?

      find_the_node_to_swap_previous_node_helper(node.left, 'right', node_to_swap)
    else
      p 'THERE ARE NO CHILDREN WITH THIS NODE'
      p "node.data: #{node.data}"
      node
    end
  end

  def find_the_node_to_swap_previous_node_helper(start_node, direction_to_go, node_to_swap)
    # p 'find_the_node_to_swap_previous_node_helper is running'
    # p "start_node.data: #{start_node.data}"
    previous_node = start_node

    if direction_to_go == 'left'
      p 'WE ARE MOVING LEFT TO FIND THE PREVIOUS NODE'
      # p previous_node.left == node_to_swap
      # p "previous_node.left: #{previous_node.left}"
      # p "node_to_swap: #{node_to_swap}"

      previous_node = previous_node.left until previous_node.left == node_to_swap

    else
      p 'WE ARE MOVING RIGHT TO FIND THE PREVIOUS NODE'
      previous_node = previous_node.right until previous_node.right == node_to_swap
    end
    previous_node
  end

  def find_node_children_info(node)
    if node.left.nil? && node.right.nil?
      'no children'
    elsif node.left.nil?
      'right child'
    elsif node.right.nil?
      'left child'
    else
      '2 children'
    end
  end

  def find_the_node_to_swap(node, node_children_info)
    case node_children_info
    when '2 children'
      return node.right if node.right.left.nil?

      find_the_node_to_swap_helper(node.right, 'left')
    when 'right child'
      return node.right if node.right.left.nil?

      find_the_node_to_swap_helper(node.right, 'left')
    when 'left child'
      return node.left if node.left.right.nil?

      find_the_node_to_swap_helper(node.left, 'right')
    else
      node
    end
  end

  def find_the_node_to_swap_helper(start_node, direction_to_go)
    p 'find_the_node_to_swap_helper is running'
    p "start node data: #{start_node.data}"
    puts

    node_to_swap = start_node
    if direction_to_go == 'left'
      node_to_swap = node_to_swap.left until node_to_swap.left.nil?
    else
      node_to_swap = node_to_swap.right until node_to_swap.right.nil?
    end
    node_to_swap
  end


  # def find_node_children_info(node)
  #   case node
  #   when 'no children'
  #     # delete_node_no_children(previous_node, previous_node_side)
  #   when 'right child'
  #     # delete_node_right_child(node, previous_node, previous_node_side)
  #   when 'left child'
  #     # delete_node_left_child(node, previous_node, previous_node_side)
  #   else
  #     # delete_and_reassign_node(node, previous_node, previous_node_side)
  #   end
  # end

  def delete_root_node(node)
    p 'delete_root_node is running'
    p node
    
  end

  def delete_node_no_children(previous_node, side)
    p 'delete_node_no_children is running'
    if side == 'left'
      previous_node.left = nil
    else
      previous_node.right = nil
    end
    p previous_node
  end

  def delete_node_right_child(node, previous_node, previous_node_side)
    case previous_node_side
    when 'right'
      previous_node.right = node.right
    when 'left'
      previous_node.left = node.right
    else
      p 'NO SIDE'
    end
  end

  def delete_node_left_child(node, previous_node, previous_node_side)
    case previous_node_side
    when 'right'
      previous_node.right = node.left
    when 'left'
      previous_node.left = node.left
    else
      p 'NO SIDE'
    end
  end

  def delete_and_reassign_node(node, previous_node, previous_node_side)
    p 'delete and reassign starting'

    if root == node
      delete_root
    else
      p 'the root is not being deleted'
      # everything_eles = everything_eles(node, previous_node, previous_node_side)
    end

    next_highest_node = find_next_highest_node(node)
    p "the next highest node is: #{next_highest_node.data}"
    p "previous_node_side: #{previous_node_side}"


  end

  def delete_root
    p "delete root is running"
  end

  def everything_eles(node, previous_node, previous_node_side)
    p 'find next highest node starting'
    p "the previous node data: #{previous_node.data}"
    p "the node to be deleted: #{node.data}"

    p "node_to_be_moved data: #{node_to_be_moved.data}"
    p "node_to_be_moved_previous_node data: #{node_to_be_moved_previous_node.data}"

    node_to_be_moved_previous_node.left = node_to_be_moved.right

    p "the node to be deleted: #{node.data}"
    node_to_be_moved.left = node.left
    node_to_be_moved.right = node.right
    p "the previous node data: #{previous_node.data}"

    case previous_node_side
    when 'left'
      previous_node.left = node_to_be_moved
    when 'right'
      previous_node.right = node_to_be_moved
    else
      p 'something happened'
    end
    # node_to_be_moved
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
