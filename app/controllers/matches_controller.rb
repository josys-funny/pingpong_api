# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /matches
  def index
    @user = User.find(params.expect(:user_id))
    @matches = @user.matches
                    .includes(:users, :match_sets, :match_users)
                    .limit(params[:limit])
                    .offset(params[:offset])
                    .order(updated_at: :desc)

    matches_json = @matches.map do |match|
      {
        id: match.id,
        match_type: match.match_type,
        created_at: match.created_at,
        updated_at: match.updated_at,
        elo: match.elo_change,
        sets: match.match_sets.map do |set|
          {
            first_team_score: set.first_team_score,
            second_team_score: set.second_team_score
          }
        end,
        users: match.match_users.map do |match_user|
          user = match.users.find { |u| u.id == match_user.user_id }
          {
            id: user.id,
            name: user.name,
            team_side: match_user.team_side,
            elo: match_user.elo
          }
        end
      }
    end

    render(json: matches_json)
  end

  # GET /matches/1
  def show
    render(json: @match)
  end

  # POST /matches
  def create
    @match = Match.new(match_params(map_custom_sets_key(params)))

    if @match.save
      render(json: @match, status: :created, location: @match)
    else
      render(json: @match.errors, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /matches/1
  def update
    if @match.update(match_params)
      render(json: @match)
    else
      render(json: @match.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /matches/1
  def destroy
    @match.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def match_params(params)
    params.permit(match_sets_attributes: %i[first_team_score second_team_score],
                  match_users_attributes: %i[user_id team_side]
                 )
  end

  def map_custom_sets_key(params)
    params[:match_sets_attributes] = params.delete(:sets) if params[:sets].present?
    params[:match_users_attributes] = params.delete(:users) if params[:users].present?
    params.delete(:match) if params[:match].present?
    params
  end
end
