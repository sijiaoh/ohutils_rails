class AddMarkdownToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :markdown, :boolean, default: false, null: false
  end
end
