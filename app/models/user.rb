class User < ActiveRecord::Base
    rolify
    
    has_many :tournaments
    has_many :tournament_participations, dependent: :destroy

    has_many :invitations, class_name: 'Invite', foreign_key: 'recipient_id'
    has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable



    def self.search(search)
      where("email LIKE ?", "%#{search}%") 
    end

    def tournament_participant? tournament_id
    	tournament = Tournament.find(tournament_id)
    	tournament.tournament_participations.exists?(user_id: self.id)
    end
end
