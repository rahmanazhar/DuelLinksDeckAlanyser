class Decks < ActiveRecord::Base
  has_and_belongs_to_many :combos
  has_and_belongs_to_many :cards
end