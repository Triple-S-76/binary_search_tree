require './binary_search_tree_2'

describe Node do
  describe 'creates a node' do
    it 'creates a node with Integer 99' do
      new_node = Node.new(99)
      expect(new_node.data).to eql(99)
    end
  end
end

describe Tree do
  describe 'creates a tree' do
    it 'creates a tree with Integer 100' do
      new_tree = Tree.new(100)
      expect(new_tree.root.data).to eql(100)
    end

    it 'creates a tree with the array [1, 2, 3]' do
      new_tree = Tree.new([1, 2, 3])
      expect(new_tree.root.data).to eql(2)
      expect(new_tree.root.left.data).to eql(1)
      expect(new_tree.root.right.data).to eql(3)
    end
  end
end

