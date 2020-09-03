class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
  end
end
