class Tournament < ActiveRecord::Base
	resourcify
	
 	belongs_to :user
 	has_many :tournament_participations
 	has_many :invites

 	validates :user, presence: true
end
