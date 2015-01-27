class RenameBestBuild < ActiveRecord::Migration
  def change
    rename_column :front_end_builds_apps, :best_build_id, :live_build_id
  end
end
