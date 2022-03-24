class AddEndpointToFrontEndBuildsBuild < ActiveRecord::Migration[4.2]
  def change
    add_column :front_end_builds_builds, :endpoint, :string, limit: 2038
  end
end
