class AddColumnsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :comment_id, :integer
    add_column :votes, :post_id, :integer
  end
end
