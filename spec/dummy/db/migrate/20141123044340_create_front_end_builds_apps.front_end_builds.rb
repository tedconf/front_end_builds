# This migration comes from front_end_builds (originally 20141010165726)
class CreateFrontEndBuildsApps < ActiveRecord::Migration
  def change
    create_table :front_end_builds_apps do |t|
      t.string :name
      t.string :api_key

      t.timestamps
    end

    add_index :front_end_builds_apps, :name
    add_index :front_end_builds_apps, :api_key
  end
end
