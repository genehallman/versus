class MatchResultController < ApplicationController
  before_filter :authenticate_user!
  def index
    @matches = MatchResult.paginate(:page => params[:page]).order('created_at DESC')
  end

  def new
    @match = MatchResult.new
  end

  def create
    @match = MatchResult.new(params[:match_result])
    @match.creator = current_user
    if @match.save
      puts "success"
      redirect_to (params['return_to'] || root_path), notice: 'Match result was successfully created.'
    else
      puts "errors"
      redirect_to (params['return_to'] || root_path), alert: @match.errors.full_messages.join('<br />')
    end
  end

  def destroy
    @match = MatchResult.find(params[:id])
    @match.destroy
    redirect_to :index, notice: 'Match result was successfully deleted.'
  end
end
