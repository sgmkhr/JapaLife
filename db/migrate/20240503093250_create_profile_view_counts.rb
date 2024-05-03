class CreateProfileViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_view_counts do |t|
      t.integer :viewer_id
      t.integer :viewed_id

      t.timestamps
    end
  end
end
