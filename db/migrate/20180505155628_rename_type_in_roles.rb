class RenameTypeInRoles < ActiveRecord::Migration[5.1]
  def change
    rename_column :roles, :type, :rtype
  end
end
