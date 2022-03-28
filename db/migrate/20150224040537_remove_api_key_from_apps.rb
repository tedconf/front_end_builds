class RemoveApiKeyFromApps < ActiveRecord::Migration[4.2]
  def change
    remove_column :front_end_builds_apps, :api_key
  end
end
