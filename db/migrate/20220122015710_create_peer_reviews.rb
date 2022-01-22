class CreatePeerReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :peer_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :space, null: false, foreign_key: true
      t.string :title, null: false
      t.string :hashid
      t.integer :status, null: false

      t.timestamps
    end
    add_index :peer_reviews, :hashid, unique: true
  end
end
