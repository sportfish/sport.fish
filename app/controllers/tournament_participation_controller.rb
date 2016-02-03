class TournamentParticipationController < ApplicationController

	# POST /tournaments/:id/join
	def create
		@tournament = Tournament.find(params[:id])
		@tournament_participation = @tournament.tournament_participations.build(user_id: current_user.id)
		if @tournament_participation.save
			flash[:success] = "You have joined #{@tournament.name}."
			redirect_to @tournament
		else
			flash[:error] = @tournament_participation.errors.full_messages.to_sentence
			redirect_to @tournament
		end
	end

	# DELETE /tournaments/:tournament_id/participation/:id
	def destroy
		@tournament = Tournament.find(params[:tournament_id])
		@tournament_participation = TournamentParticipation.find(params[:id])
		if @tournament_participation.destroy
			flash[:notice] = "You have left #{@tournament.name}."
			redirect_to @tournament
		else
			flash[:error] = "Unable to delete participation"
			redirect_to @tournament
		end
	end
	# before_filter :authenticate_user!
	# def create
	# 	@tournament_participation = current_user.tournament_participations.build(tournament_id: params[:tournament_id])
	# 	if @tournament_participation.save
	#       redirect_to(@tournament, notice: 'You have joined this tournament.')
	#     else
	#       redirect_to(@tournament, notice: 'Unable to join this tournament.')
	#     end
	# end

	# def destroy
	# 	@tournament_participation = current_user.tournament_participations.find(params[:id])
	# 	@tournament_participation.destroy
	# end
end
