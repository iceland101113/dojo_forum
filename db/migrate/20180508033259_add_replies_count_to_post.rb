class AddRepliesCountToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :replies_count, :integer
  end
end
