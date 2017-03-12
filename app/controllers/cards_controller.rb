class CardsController < ApplicationController
  def index
    @cards = Cards.first(50)
    @from_index_controller=true
  end
  def show
    @card = Cards.find(params[:id])
  end
end
