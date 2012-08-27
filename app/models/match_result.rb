class MatchResult < ActiveRecord::Base

  belongs_to :winner, :class_name => "User"
  belongs_to :loser, :class_name => "User"
  belongs_to :creator, :class_name => "User"
  
  validates_presence_of :winner_id, :loser_id, :creator_id

  before_create :calculate_points
  
  attr_accessible :winner_id, :loser_id, :creator_id
  
  SCORE_GROUPS = [
    {diff_hi:0,   diff_low:12,      expected:8, unexpected:8},
    {diff_hi:13,  diff_low:37,      expected:7, unexpected:10},
    {diff_hi:38,  diff_low:62,      expected:6, unexpected:13},
    {diff_hi:63,  diff_low:87,      expected:5, unexpected:16},
    {diff_hi:88,  diff_low:112,     expected:4, unexpected:20},
    {diff_hi:113, diff_low:137,     expected:3, unexpected:25},
    {diff_hi:138, diff_low:162,     expected:2, unexpected:30},
    {diff_hi:163, diff_low:187,     expected:2, unexpected:35},
    {diff_hi:188, diff_low:212,     expected:1, unexpected:40},
    {diff_hi:213, diff_low:237,     expected:1, unexpected:45},
    {diff_hi:238, diff_low:9999999, expected:0, unexpected:50},
  ]

  def calculate_points
    diff = (self.winner.score - self.loser.score).abs
    mgroup = {expected:0, unexpected:0}
        
    SCORE_GROUPS.each do |group|
      mgroup = group if diff >= group[:diff_hi] and diff <= group[:diff_low]
    end
    
    self.point_transfer = (self.winner.score > self.loser.score) ? mgroup[:expected] : mgroup[:unexpected]
    self.winner.score += self.point_transfer
    self.loser.score -= self.point_transfer
    self.winner.save
    self.loser.save
  end
end
