class AddScoreAndDisplayNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer, :default => 500, :null => false
    add_column :users, :display_name, :string
  end
end
