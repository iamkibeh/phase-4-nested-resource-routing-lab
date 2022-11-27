class UsersController < ApplicationController

  def show
    if params[:id]
      user = User.find_by(id: params[:id])
    else  
      user = User.find_by(id: params[:id]).items
    end
    render json: user, include: :items
  end

end
