class CreateFruits < ActiveRecord::Migration[7.0]
  def change
    create_table :fruits do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
