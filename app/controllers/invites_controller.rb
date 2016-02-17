class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]

  # GET /invites
  def index
    @invites = Invite.all
  end

  # GET /invites/1
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)
    @invite.sender_id = current_user.id # set the sender to the current user
    @tournament = @invite.tournament
    # abstract the new/existing user check to invite model or mailer
    if @invite.save
      if @invite.recipient != nil
        InviteMailer.invite_existing_user(@invite).deliver # send a notification email
        tournament_participation = @tournament.tournament_participations.build(user_id: @invite.recipient_id) # Add the user to the tournament
        tournament_participation.save
      else
        InviteMailer.invite_user(@invite, new_user_registration_path(:invite_token => @invite.token)).deliver
      end
      redirect_to @tournament, notice: 'Invite was successfully created.'
    else
      # oh no, creating an new invitation failed
    end
  end

  # PATCH/PUT /invites/1
  def update
    if @invite.update(invite_params)
      redirect_to @invite, notice: 'Invite was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /invites/1
  def destroy
    @invite.destroy
    redirect_to invites_url, notice: 'Invite was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invite
      @invite = Invite.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invite_params
      params.require(:invite).permit(:tournament_id, :email)
    end
end
