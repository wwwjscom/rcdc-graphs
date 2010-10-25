class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name
      t.string :supply_host
      t.string :col_1
      t.string :col_2
      t.string :total
      t.date :for_date

      t.timestamps
    end
  end

  def self.down
    drop_table :markets
  end
end
