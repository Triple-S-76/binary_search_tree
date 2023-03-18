require './binary_search_tree_2'

describe Node do
  describe 'new_node' do
    it 'makes a new node' do
      new_node = Node.new(99)
      expect(new_node.data).to eq 99
    end
  end
end

describe Tree do
  describe 'makes a new tree' do
    it 'makes a new tree and checks it' do
      array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      new_tree = Tree.new
      new_tree.build_tree(array)
      expect(new_tree.level_order_recursive).to eq [8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]
      expect(new_tree.level_order_loop).to eq [8, 4, 12, 2, 6, 10, 14, 1, 3, 5, 7, 9, 11, 13, 15]
      expect(new_tree.preorder_recursive).to eq [8, 4, 2, 1, 3, 6, 5, 7, 12, 10, 9, 11, 14, 13, 15]
      expect(new_tree.preorder_loop).to eq [8, 4, 2, 1, 3, 6, 5, 7, 12, 10, 9, 11, 14, 13, 15]
      expect(new_tree.inorder_recursive).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      expect(new_tree.inorder_loop).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
      expect(new_tree.postorder_recursive).to eq [1, 3, 2, 5, 7, 6, 4, 9, 11, 10, 13, 15, 14, 12, 8]
    end
  end
end

describe Tree do
  describe 'tests the insert and find methods' do
    it 'makes a new tree and inserts some numbers and checks it' do
      array = [1, 2, 3, 4, 5, 6, 7]
      new_tree = Tree.new
      new_tree.build_tree(array)
      new_tree.insert(99)
      new_tree.insert(5.5)
      new_tree.insert(0.5)
      expect(new_tree.level_order_recursive).to eq [4, 2, 6, 1, 3, 5, 7, 0.5, 5.5, 99]
      find99 = new_tree.find(99)
      expect(find99.data).to eq 99
      find5 = new_tree.find(5)
      expect(find5.data).to eq 5
    end
  end
end

