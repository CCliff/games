class AddNumguessColumnToHangmanGames < ActiveRecord::Migration
  def change
    add_column :hangman_games, :num_guesses, :integer
  end
end
