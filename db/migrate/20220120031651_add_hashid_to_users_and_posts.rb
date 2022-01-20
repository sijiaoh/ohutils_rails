class AddHashidToUsersAndPosts < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :hashid
      t.index :hashid, unique: true
    end

    change_table :posts, bulk: true do |t|
      t.string :hashid
      t.index :hashid, unique: true
    end
  end
end
