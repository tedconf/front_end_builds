class AddClientToFrontEndBuildsApp < ActiveRecord::Migration
  def change
    add_column :front_end_builds_apps, :client, :string
  end
end
