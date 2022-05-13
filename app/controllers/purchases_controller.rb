class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item

  def index
    @purchase_address = PurchaseAddress.new
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase.present?
    card = Card.find_by(user_id: current_user.id)

    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
      @purchase_address.token = current_user.card.customer_token
    end
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    if @card.present?
      customer_token = current_user.card.customer_token
      Payjp::Charge.create(
        amount: @item.price,
        customer: customer_token,
        currency: 'jpy'
      )
    else
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
    end
  end
end
