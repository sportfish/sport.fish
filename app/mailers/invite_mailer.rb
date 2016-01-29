class InviteMailer < ApplicationMailer
	default from: "admin@timand.co"

	def invite_user user
		@user = user
		mail(to: @user.email, subject: "You've been invited!")
	end

	private

	def invite_new_user
	end
end
