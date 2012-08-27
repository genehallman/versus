class AddCreaterToMatchResult < ActiveRecord::Migration
  def change
    add_column :match_results, :creator_id, :integer
  end
end
