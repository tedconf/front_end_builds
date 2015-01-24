class AddPubkeyToBuild < ActiveRecord::Migration
  def change
    # Track what public deployed each build
    add_column :front_end_builds_builds, :pubkey_id, :integer
    add_column :front_end_builds_builds, :signature, :text
  end
end
