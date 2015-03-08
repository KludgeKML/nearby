class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :item
      t.integer :category
      t.integer :value
      t.timestamps
    end
  end
end
