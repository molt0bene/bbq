class RemoveUploaderFields < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :avatar, :string
    remove_column :photos, :photo, :string
  end
end
