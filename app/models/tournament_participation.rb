class TournamentParticipation < ActiveRecord::Base
  belongs_to :user
  belongs_to :tournament

  validates :user_id, uniqueness: { scope: :tournament_id, message: "You can only join a tournament once." }
  validates :user_id, :tournament_id, presence: true
end
