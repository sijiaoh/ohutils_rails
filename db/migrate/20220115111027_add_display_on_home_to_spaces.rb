class AddDisplayOnHomeToSpaces < ActiveRecord::Migration[7.0]
  def change
    add_column :spaces, :display_on_home, :boolean, default: false, null: false
  end
end
