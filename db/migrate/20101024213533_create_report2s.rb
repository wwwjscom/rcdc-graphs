class CreateReport2s < ActiveRecord::Migration
  def self.up
    create_table :report2s do |t|
      t.date :start_date
      t.date :end_date
      t.string :graph_type

      t.timestamps
    end
  end

  def self.down
    drop_table :report2s
  end
end
