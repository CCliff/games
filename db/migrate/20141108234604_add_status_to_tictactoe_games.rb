class AddStatusToTictactoeGames < ActiveRecord::Migration
  def change
    add_column :tictactoe_games, :active?, :boolean
  end
end
