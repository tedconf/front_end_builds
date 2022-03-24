class AddBuildRefToApps < ActiveRecord::Migration[4.2]
  def change
    add_column :front_end_builds_apps, :live_build_id, :integer
  end
end
