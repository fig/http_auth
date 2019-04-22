class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.integer :temperature
      t.belongs_to :raspberry, foreign_key: true

      t.timestamps
    end
  end
end
