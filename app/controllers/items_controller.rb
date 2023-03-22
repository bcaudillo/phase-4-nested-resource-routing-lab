class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_found_error

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else 
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(params.permit(:name, :description, :price))
    render json: item, status: :created
  end

  private 

  def user_not_found_error
    render json: {error: "nah bro"}, status: :not_found
  end

end
