class RequireManualActivation < ActiveRecord::Migration
  def change
    add_column :front_end_builds_apps,
      :require_manual_activation,
      :boolean,
      default: false
  end
end
