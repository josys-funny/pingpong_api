# frozen_string_literal: true

class MatchHistoriesController < ApplicationController
  before_action :set_match_history, only: %i[show update destroy]

  # GET /match_histories
  def index
    @match_histories = MatchHistory.all

    render(json: @match_histories)
  end

  # GET /match_histories/1
  def show
    render(json: @match_history)
  end

  # POST /match_histories
  def create
    @match_history = MatchHistory.new(match_history_params)

    if @match_history.save
      render(json: @match_history, status: :created, location: @match_history)
    else
      render(json: @match_history.errors, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /match_histories/1
  def update
    if @match_history.update(match_history_params)
      render(json: @match_history)
    else
      render(json: @match_history.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /match_histories/1
  def destroy
    @match_history.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match_history
    @match_history = MatchHistory.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def match_history_params
    params.fetch(:match_history, {})
  end
end
