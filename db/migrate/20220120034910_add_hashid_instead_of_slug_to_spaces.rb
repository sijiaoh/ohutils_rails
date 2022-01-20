class AddHashidInsteadOfSlugToSpaces < ActiveRecord::Migration[7.0]
  def up # rubocop:disable Metrics/MethodLength
    change_table :spaces, bulk: true do |t|
      t.string :hashid
      t.index :hashid, unique: true
    end

    Space.all.each do |space|
      space.hashid = space.slug
      space.save!
    end

    change_table :spaces, bulk: true do |t|
      t.remove_index :slug
      t.remove :slug
    end
  end
end
