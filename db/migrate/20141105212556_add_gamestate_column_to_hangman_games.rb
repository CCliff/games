class AddGamestateColumnToHangmanGames < ActiveRecord::Migration
  def change
    add_column :hangman_games, :game_state, :string
  end
end
