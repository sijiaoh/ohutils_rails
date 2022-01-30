class CreatePeerReviewsParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :peer_reviews_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :peer_review, null: false, foreign_key: true
      t.string :hashid
      t.text :comment, null: false

      t.timestamps

      t.index %i[user_id peer_review_id], unique: true
    end
    add_index :peer_reviews_participations, :hashid, unique: true
  end
end
