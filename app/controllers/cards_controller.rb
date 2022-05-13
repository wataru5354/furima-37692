class CardsController < ApplicationController
  def new
    session[:previous_url] = request.referer
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )

    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      redirect_to session[:previous_url]
    else
      redirect_to action: "new"
    end
  end

  def session_clear
    session[:previous_url].clear
  end
end
