class InviteMailer < ApplicationMailer
	default from: "admin@timand.co"

	def invite_user user, url
		@user = user
		@url = url
		mail(to: @user.email, from: "admin@timand.co", subject: "You've been invited!")
	end

	def invite_existing_user user
		@user = user
		mail(to: @user.email, subject: "You've been invited!")
	end

	private

	def invite_new_user
	end
end
