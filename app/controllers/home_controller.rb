class HomeController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page]).order('score DESC')
  end
end
