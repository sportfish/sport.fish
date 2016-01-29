class User < ActiveRecord::Base
    rolify
    
    has_many :tournaments
    has_many :tournament_participations
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
end
