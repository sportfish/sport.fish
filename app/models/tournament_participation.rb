class TournamentParticipation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament
end
