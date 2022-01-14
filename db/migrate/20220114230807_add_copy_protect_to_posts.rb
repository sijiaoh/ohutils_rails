class AddCopyProtectToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :copy_protect, :boolean, default: true, null: false
  end
end
