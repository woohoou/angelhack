# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  content    :string(255)
#  latitude   :float
#  longitude  :float
#  gmaps      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :string(255)      default("1")
#  user_id    :integer          not null
#  venue_id   :integer          not null
#

class Report < ActiveRecord::Base
  attr_accessible :content, :state, :user_id, :venue_id, :name

  belongs_to :user
  belongs_to :venue, touch: true
  has_many :votes
  has_many :comments
  has_many :surveys

  validates :venue_id, presence: true
  validates :user_id, presence: true

  STATES = {
    0 => :pendiente,
    1 => :en_revision,
    2 => :recompensado,
    3 => :spam,
    4 => :revisado
  }

  def positive_votes
    self.votes.where(calification: true).size
  end

  def negative_votes
    self.votes.where(calification: false).size
  end
    
  state_machine :state, initial: :pendiente do

   	STATES.each do |value,name|
        state name, value: value
    end

  	event :review do
  		transition :pendiente => :revisado
  	end

  	event :not_review do
  		transition :revisado => :pendiente
  	end

  	event :in_review do
  		transition :pendiente => :en_revision
  	end

  	event :reward do
  		transition :revisado => :recomensado
  	end

  	event :spamed do
  		transition any => :spam
  	end

  	event :not_spamed do
  		transition :spam => :pendiente
  	end

  	state :revisado
  	state :pendiente
  	state :en_revision
  	state :recomensado
  	state :spam

  end
  
end
