class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name
      t.string :one_v
      t.string :all
      t.string :DCHH
      t.string :GTA
      t.string :HET
      t.string :OMH
      t.string :PDN
      t.string :PEG
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :markets
  end
end
