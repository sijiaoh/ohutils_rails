class CreatePeerReviewsReviews < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :peer_reviews_reviews do |t|
      t.string :hashid
      t.references :peer_review, null: false, foreign_key: true
      t.references :reviewer_participation, null: false, foreign_key: { to_table: :peer_reviews_participations }
      t.references :reviewee_participation, null: false, foreign_key: { to_table: :peer_reviews_participations }
      t.integer :fun, null: false
      t.integer :technical, null: false
      t.integer :creativity, null: false
      t.integer :composition, null: false
      t.integer :growth, null: false
      t.text :comment, null: false

      t.timestamps

      t.index :hashid, unique: true
      t.index([:reviewer_participation_id, :reviewee_participation_id],
              unique: true,
              name: "index_peer_reviews_reviews_on_reviewer_p_id_and_reviewee_p_id")
    end
  end
end
