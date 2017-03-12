class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps null: false
    end
    
    create_table :cards do |c|
      c.string :name
      c.string :key
      c.integer :attack
      c.integer :defense
      c.integer :level
      c.string :card_type
      c.string :attribute_value
      c.string :monster_type
      c.string :card_effect_type
      c.string :property
    end
    
    create_table :decks do |d|
      d.integer :deck_id
      d.belongs_to :user, index: true
    end

    create_table :decks_cards do |d|
      d.belongs_to :decks, index:true
      d.belongs_to :cards, index: true
    end
    
    create_table :decks_combos do |d|
      d.belongs_to :combos, index: true
      d.belongs_to :decks, index:true
    end
    
    create_table :combos do |c|
      c.integer :combo_id
      c.belongs_to :cards, index:true
    end

  end
end
