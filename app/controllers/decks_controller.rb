class DecksController < ApplicationController
  
  def index
    @decks = current_user.decks
  end
  
  def show
      @deck = Deck.find(params[:id])
      @cards = @deck.cards
      @cards_all = Card.first(5)
      @from_decks_show=true;
  end
  
  def create
    @deck = current_user.decks.new
    if @deck.save
        redirect_to @deck
    else
        render "new"
    end
  end
  
  def new
      Deck.new
  end
  
  def add
    @card = Card.find(params[:card_id])


    
    @deck = Deck.find(params[:deck_id])
    @deck.cards << @card
    if @deck.save && @card.save
      redirect_to @deck
    else
      redirect_to "decks_path"
    end
  end
  
end
