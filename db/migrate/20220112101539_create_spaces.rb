class CreateSpaces < ActiveRecord::Migration[7.0]
  def change
    create_table :spaces do |t|
      t.string :slug, null: false
      t.string :name, null: false

      t.timestamps

      t.index :slug, unique: true
    end
  end
end
