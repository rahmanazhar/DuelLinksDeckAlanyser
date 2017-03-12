class CardsController < ApplicationController
  def index
    @cards_all = Card.first(50)
    @from_cards_index=true
  end
  def show
    @card = Card.find(params[:id])
  end
end
