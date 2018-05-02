class AddSituationToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :situation, :string
  end
end
