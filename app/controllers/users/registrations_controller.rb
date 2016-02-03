class Users::RegistrationsController < Devise::RegistrationsController
  # def new
  #   super
  # end

  # def create
  #   super
  # end

  def new
  	@token = params[:invite_token] # pulls the value from the url query string
  	super
  end

  def create
  	@newUser = build_user(user_params)
  	@newUser.save
  	@token = params[:invite_token]
  	if @token != nil
     	tournament =  Invite.find_by_token(@token).tournament # find the tournament attached to the invite
     	@newUser.tournaments.push(tournament) # add this user to the new tournament as a member
  	else
    	super
  	end
end
