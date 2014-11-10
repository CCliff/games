class DeleteInactiveColumnsTictactoeGames < ActiveRecord::Migration
  def change
    remove_columns :tictactoe_games, :user_1
    remove_columns :tictactoe_games, :user_2
    remove_columns :tictactoe_games, :last_move
  end
end
