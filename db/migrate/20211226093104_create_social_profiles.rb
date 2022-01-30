class CreateSocialProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :social_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :email, null: false

      t.timestamps

      t.index %i[user_id provider], unique: true
      t.index %i[provider uid], unique: true
    end
  end
end
