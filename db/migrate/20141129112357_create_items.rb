class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :uuid, null: false, index: true
      t.string :owner, null: false, index: true
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
