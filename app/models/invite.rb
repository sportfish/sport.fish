class Invite < ActiveRecord::Base
	belongs_to :tournament
	belongs_to :sender, :class_name => 'User'
	belongs_to :recipient, :class_name => 'User'

	# rails 5 includes SecureToken class method has_secure_token :auth_token
	# has_secure_token :auth_token genrates token using SecureRandom.base58
	before_create :generate_token
	before_save :check_user_existence

	private

	def generate_token
		self.token = Digest::SHA1.hexdigest([self.tournament_id, Time.now, rand].join)
	end

	def check_user_existence
 		recipient = User.find_by_email(email)
   		if recipient
      		self.recipient_id = recipient.id
   		end
	end
end
