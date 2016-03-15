class CreateFrontEndBuildsApps < ActiveRecord::Migration
  def change
    create_table :front_end_builds_apps do |t|
      t.string :name, limit: 191
      t.string :api_key, limit: 191

      t.timestamps
    end

    add_index :front_end_builds_apps, :name
    add_index :front_end_builds_apps, :api_key
  end
end
