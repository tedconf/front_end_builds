class CreateFrontEndBuildsPubkeys < ActiveRecord::Migration
  def change
    create_table :front_end_builds_pubkeys do |t|
      t.string :name, null: false, limit: 191
      t.text :pubkey, null: false

      t.timestamps null: false
    end
  end
end
