class AddNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: "", null: false

    ActiveRecord::Base.transaction do
      User.all.each do |user|
        user.name = "username"
        user.save!
      end
    end
  end
end
