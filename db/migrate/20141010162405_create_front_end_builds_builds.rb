class CreateFrontEndBuildsBuilds < ActiveRecord::Migration[4.2]
  def change
    create_table :front_end_builds_builds do |t|
      t.references :app
      t.string :sha, limit: 191
      t.string :job, limit: 191
      t.string :branch, limit: 191
      t.text :html
      t.boolean :fetched, default: false
      t.boolean :active, default: false

      t.timestamps
    end

    add_index :front_end_builds_builds, :fetched
    add_index :front_end_builds_builds, :active
    add_index :front_end_builds_builds, :created_at
    add_index :front_end_builds_builds, [:app_id, :branch]
    add_index :front_end_builds_builds, [:app_id, :sha]
    add_index :front_end_builds_builds, [:app_id, :job]
  end
end
