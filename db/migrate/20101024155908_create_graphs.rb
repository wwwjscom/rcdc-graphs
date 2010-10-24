class CreateGraphs < ActiveRecord::Migration
  def self.up
    create_table :graphs do |t|
      t.date :start_date
      t.date :end_date
      t.string :graph_type

      t.timestamps
    end
  end

  def self.down
    drop_table :graphs
  end
end
