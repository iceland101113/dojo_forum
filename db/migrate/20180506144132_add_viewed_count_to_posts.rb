class AddViewedCountToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :viewed_count, :integer
  end
end
