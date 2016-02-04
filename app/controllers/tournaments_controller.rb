class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :join]
  before_action :check_role, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /tournaments
  def index
    # no N+1 query with includes(:user)
    # @tournaments = Tournament.all
    @tournaments = Tournament.includes(:user)
  end

  # GET /tournaments/1
  def show
    @participation = current_user.tournament_participations.find_by(tournament_id: @tournament.id)
    @invite = Invite.new
  end

  # GET /tournaments/new
  def new
    @tournament = Tournament.new
  end

  # GET /tournaments/1/edit
  def edit
    @invite = Invite.new
  end

  # POST /tournaments
  def create
    @tournament = Tournament.new(tournament_params)
    user = current_user
    @tournament.user_id = user.id

    # append admin role to tournament user
    if @tournament.save
      user.add_role :admin, @tournament
      user.save
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tournaments/1
  def update
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: 'Tournament was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tournaments/1
  def destroy
    @tournament.destroy
    redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.'
  end

  # GET /tournaments/1/join
  def join
    @tournament_participation = @tournament.tournament_participations.build(user_id: current_user.id)
    if @tournament_participation.save
      redirect_to @tournament, notice: "You have joined #{@tournament.name}"
    else
      flash[:error] = @tournament_participation.errors.full_messages.to_sentence
      redirect_to @tournament
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tournament
      @tournament = Tournament.find(params[:id])
    end

    def check_role
      user = current_user
      unless user.has_role? :admin, @tournament
        redirect_to root_path, notice: 'You are not a tournament admin.'
      end
    end

    # Only allow a trusted parameter "white list" through.
    def tournament_params
      params.require(:tournament).permit(:name, :location, :start_time)
    end
end
