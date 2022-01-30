class CreateGuestProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :guest_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :hashid
      t.string :student_number, null: false

      t.timestamps

      t.index :hashid, unique: true
      t.index :student_number, unique: true
    end
  end
end
