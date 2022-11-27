class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      items = Item.find_by!(user_id: params[:user_id]).user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    if params[:user_id]
      item = Item.find_by!(id: params[:id])
      return render json: item , status: 200
    else  
      item = Item.find_by(id: params[:id])
      return render json: item , status: 200
    end
  end

  def create
    if params[:user_id]
      item = Item.create({name: item_params[:name], description: item_params[:description], price: item_params[:price], user_id: params[:user_id]})
    end
    render json: item, status: :created
  end

  private


  def render_not_found_response
    render json: { error: "Item not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end
end
