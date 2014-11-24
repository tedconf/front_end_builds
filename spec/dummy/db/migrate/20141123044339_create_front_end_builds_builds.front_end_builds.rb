# This migration comes from front_end_builds (originally 20141010162405)
class CreateFrontEndBuildsBuilds < ActiveRecord::Migration
  def change
    create_table :front_end_builds_builds do |t|
      t.references :app
      t.string :sha
      t.string :job
      t.string :branch
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
