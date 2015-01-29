class AddBuildRefToApps < ActiveRecord::Migration
  def change
    add_column :front_end_builds_apps, :live_build_id, :integer
  end
end
