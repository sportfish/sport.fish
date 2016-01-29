class User < ActiveRecord::Base
    rolify
    
    has_many :tournaments
    has_many :tournament_participations

    has_many :invitations, class_name: 'Invite', foreign_key: 'recipient_id'
    has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
end
