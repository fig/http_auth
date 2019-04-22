# frozen_string_literal: true

class CreateRaspberries < ActiveRecord::Migration[5.2]
  def change
    create_table :raspberries do |t|
      t.string :location

      t.timestamps
    end
  end
end
