class Combos < ActiveRecord::Base
  has_and_belongs_to_many :decks
  has_many :cards
end