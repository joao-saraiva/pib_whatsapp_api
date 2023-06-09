# frozen_string_literal: true

class MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /matches
  def index
    @matches = Match.all

    render json: @matches
  end

  # GET /matches/1
  def show
    render json: @match
  end

  # POST /matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  def destroy
    @match.destroy
  end

  def cancel
    match = Match.open.last

    if match
      match.cancel!
      render plain: "Partida cancelada !"
    else
      render plain: "Não existe partida para cancelar"
    end
  end

  def print_list
    match = Match.open.last

    if match
      render plain: match.print_list_of_players
    else
      render plain: "Não existe partida para visualizar a lista"
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def match_params
    params.require(:match).permit(:status, :date)
  end
end
