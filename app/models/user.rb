class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  has_many :matches_won, :class_name => "MatchResult", :foreign_key => "winner_id"
  has_many :matches_lost, :class_name => "MatchResult", :foreign_key => "loser_id"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :display_name, :score
  
  validates :email, :format => { :with => /.*@livefyre.com$/, :message => "Wrong email domain." }, :on => :create
  validates_uniqueness_of :email, :on => :create
  validates_presence_of :display_name
  
  def last_matches(count)
    won = matches_won.order('created_at DESC').first(count)
    lost = matches_lost.order('created_at DESC').first(count)
    matches = won + lost
    matches.sort_by! { |m| m.created_at }
    matches.reverse.first(count)
  end
end
