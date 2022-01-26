class CreatePeerReviewsReviews < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :peer_reviews_reviews do |t|
      t.string :hashid, null: false
      t.references :peer_review, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :peer_reviews_participations }
      t.references :reviewee, null: false, foreign_key: { to_table: :peer_reviews_participations }
      t.integer :like, null: false
      t.integer :technical, null: false
      t.integer :creativity, null: false
      t.integer :composition, null: false
      t.integer :growth, null: false
      t.string :comment, null: false

      t.timestamps

      t.index :hashid, unique: true
      t.index [:reviewer_id, :reviewee_id], unique: true
    end
  end
end
