#spec/binary_search_tree_spec.rb
require './binary_search_tree'

describe Node do
  describe 'new_node' do
    it 'makes a new node' do
      new_node = Node.new(2)
      expect(new_node.data).to be == 2
    end
  end
end

describe Tree do
  before(:each) do
    @new_tree = Tree.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
  end

  describe 'new tree' do
    it 'checks to make sure that the new tree is balanced' do
      expect(@new_tree.root.data).to be == 5
      expect(@new_tree.root.left.data).to be == 2
      expect(@new_tree.root.left.left.data).to be == 1
      expect(@new_tree.root.left.right.data).to be == 3
      expect(@new_tree.root.left.right.right.data).to be == 4
      expect(@new_tree.root.left.data).to be == 2
      expect(@new_tree.root.right.data).to be == 8
      expect(@new_tree.root.right.left.data).to be == 6
      expect(@new_tree.root.right.left.right.data).to be == 7
      expect(@new_tree.root.right.right.data).to be == 9
      expect(@new_tree.root.right.right.right.data).to be == 10
    end
  end

  describe 'checks Find method' do
    it 'checks various Find commands' do
      expect(@new_tree.find(4)).to be == '4 is in the tree'
      expect(@new_tree.find(4.5)).to be == '4.5 is not in the tree'
      expect(@new_tree.find('j')).to be == "'j' is invalid"
    end
  end

  describe 'checks Insert method' do
    it 'inserts some elements and checks that they are correctly handled' do
      @new_tree.insert(99)
      expect(@new_tree.find(99)).to be == '99 is in the tree'
      expect(@new_tree.root.right.right.right.right.data).to be == 99
      @new_tree.insert(89)
      expect(@new_tree.find(89)).to be == '89 is in the tree'
      expect(@new_tree.root.right.right.right.right.left.data).to be == 89
      @new_tree.insert(2.5)
      expect(@new_tree.find(2.5)).to be == '2.5 is in the tree'
      expect(@new_tree.root.left.right.left.data).to be_within(0.001).of(2.5)
      @new_tree.insert(-22)
      expect(@new_tree.find(-22)).to be == '-22 is in the tree'
      expect(@new_tree.root.left.left.left.data).to be == -22
      expect(@new_tree.insert('j')).to be == "'j' is invalid"
      # 3.times { puts }
      # puts @new_tree.pretty_print
    end
  end
end
