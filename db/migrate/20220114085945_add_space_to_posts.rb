class AddSpaceToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :space, null: false, foreign_key: true # rubocop:disable Rails/NotNullColumn
  end
end
