class AddPasswordToStudentProfiles < ActiveRecord::Migration[7.0]
  def change
    change_table :student_profiles, bulk: true do |t|
      t.column :password, :string, null: false
    end
  end
end
