# This migration comes from front_end_builds (originally 20141105222855)
class AddEndpointToFrontEndBuildsBuild < ActiveRecord::Migration
  def change
    add_column :front_end_builds_builds, :endpoint, :string, limit: 2038
  end
end
