class CreateMatchResults < ActiveRecord::Migration
  def change
    create_table :match_results do |t|
      t.belongs_to :winner
      t.belongs_to :loser
      t.integer :point_transfer
      t.timestamps
    end
  end
end
