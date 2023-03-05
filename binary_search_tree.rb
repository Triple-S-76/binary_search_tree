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

  def delete(element)
    node_to_delete_info = get_node_to_delete_info(element)
    if node_to_delete_info[:node_to_delete].nil?
      p 'Element is not in the tree'
    else
      delete_node(node_to_delete_info)
    end
  end

  def delete_node(node_to_delete_info)
    if node_to_delete_info[:node_is_root] == true
      if node_to_delete_info[:node_is_leaf] == true
        @root = Node.new
      elsif node_to_delete_info[:left_child].nil?
        @root = node_to_delete_info[:right_child]
      elsif node_to_delete_info[:right_child].nil?
        @root = node_to_delete_info[:left_child]
      else
        node_to_move_info = find_node_to_move(node_to_delete_info)
        delete_node_with_two_children(node_to_delete_info, node_to_move_info)
      end
    else # above here is only if the node to delete is root
      if node_to_delete_info[:node_is_leaf] == true
        if node_to_delete_info[:parent_node_side] == 'left'
          node_to_delete_info[:parent_node].left = nil
        else
          node_to_delete_info[:parent_node].right = nil
        end
      elsif node_to_delete_info[:left_child].nil?
        if node_to_delete_info[:parent_node_side] == 'left'
          node_to_delete_info[:parent_node].left = node_to_delete_info[:right_child]
        else
          node_to_delete_info[:parent_node].right = node_to_delete_info[:right_child]
        end
      elsif node_to_delete_info[:right_child].nil?
        if node_to_delete_info[:parent_node_side] == 'left'
          node_to_delete_info[:parent_node].left = node_to_delete_info[:left_child]
        else
          node_to_delete_info[:parent_node].right = node_to_delete_info[:left_child]
        end
      else
        node_to_move_info = find_node_to_move(node_to_delete_info)
        delete_node_with_two_children(node_to_delete_info, node_to_move_info)
      end
    end
  end

  def delete_node_with_two_children(node_to_delete_info, node_to_move_info)
    if node_to_move_info[:parent_node_side] == 'left'
      node_to_move_info[:parent_node].left = node_to_move_info[:right_child]
    else
      node_to_move_info[:parent_node].right = node_to_move_info[:right_child]
    end
    if node_to_delete_info[:parent_node_side] == 'left'
      node_to_delete_info[:parent_node].left = node_to_move_info[:node_to_move]
    elsif node_to_delete_info[:parent_node_side] == 'right'
      node_to_delete_info[:parent_node].right = node_to_move_info[:node_to_move]
    else
      @root = node_to_move_info[:node_to_move]
    end
    delete_right = node_to_delete_info[:node_to_delete].right
    delete_left = node_to_delete_info[:node_to_delete].left
    node_to_move = node_to_move_info[:node_to_move]

    node_to_move.right = delete_right
    node_to_move.left = delete_left
  end

  def find_node_to_move(node_to_delete_info)
    node_to_delete_info[:parent_node] = nil if node_to_delete_info[:node_to_delete] == node_to_delete_info[:parent_node]

    if node_to_delete_info[:right_child].nil?
      node_to_move = node_to_delete_info[:left_child]
      parent_node = node_to_delete_info[:node_to_delete]
      until node_to_move.right.nil?
        parent_node = node_to_move
        node_to_move = node_to_move.right
      end
    else
      node_to_move = node_to_delete_info[:right_child]
      parent_node = node_to_delete_info[:node_to_delete]
      until node_to_move.left.nil?
        parent_node = node_to_move
        node_to_move = node_to_move.left
      end
    end
    set_node_to_move_info(node_to_move, parent_node)
  end

  def set_node_to_move_info(node_to_move, parent_node)
    node_to_move_info = make_node_info_hash
    node_to_move_info[:node_to_move] = node_to_move
    node_to_move_info[:right_child] = node_to_move.right
    node_to_move_info[:left_child] = node_to_move.left
    node_to_move_info[:parent_node] = parent_node
    node_to_move_info[:parent_node_side] = 'left' if node_to_move == parent_node.left
    node_to_move_info[:parent_node_side] = 'right' if node_to_move == parent_node.right
    node_to_move_info[:node_is_leaf] = true if node_to_move.left.nil? && node_to_move.right.nil?
    node_to_move_info
  end

  def make_node_info_hash
    node_info = {
      node_to_delete: nil,
      node_to_move: nil,
      left_child: nil,
      right_child: nil,
      parent_node: nil,
      parent_node_side: nil,
      node_is_root: false,
      node_is_leaf: false
    }
    node_info
  end

  def get_node_to_delete_info(element, current_node = root, parent_node = root)
    node_to_delete_info = make_node_info_hash

    return node_to_delete_info if current_node.data.nil?
    if element < current_node.data
      get_node_to_delete_info(element, current_node.left, current_node)
    elsif element > current_node.data
      get_node_to_delete_info(element, current_node.right, current_node)
    elsif element == current_node.data
      node_to_delete_info[:node_to_delete] = current_node
      node_to_delete_info[:left_child] = current_node.left
      node_to_delete_info[:right_child] = current_node.right
      node_to_delete_info[:parent_node] = parent_node
      node_to_delete_info[:parent_node_side] = 'left'  if current_node == parent_node.left
      node_to_delete_info[:parent_node_side] = 'right' if current_node == parent_node.right
      node_to_delete_info[:node_is_root] = true if current_node == root
      node_to_delete_info[:node_is_leaf] = true if current_node.left.nil? && current_node.right.nil?
      node_to_delete_info
    end
  end

  def level_order(block = root)
    queue = [block]
    array_of_data_values = []

    loop do
      break if queue.empty?

      current = queue[0]
      array_of_data_values << current.data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
      queue.shift
    end
    array_of_data_values
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
