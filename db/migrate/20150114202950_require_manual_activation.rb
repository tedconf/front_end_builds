class RequireManualActivation < ActiveRecord::Migration[4.2]
  def change
    add_column :front_end_builds_apps,
      :require_manual_activation,
      :boolean,
      default: false
  end
end
