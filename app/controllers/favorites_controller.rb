class FavoritesController < ApplicationController
  before_action :set_item

  def create
    @item_favorite = Favorite.new(user_id: current_user.id, item_id: params[:item_id])
    @item_favorite.save
  end

  def destroy
    @item_favorite = Favorite.find_by(user_id: current_user.id,item_id: params[:item_id])
    @item_favorite.destroy
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
