class CreateHangmanGamesTable < ActiveRecord::Migration
  def change
    create_table :hangman_games do |t|
      t.references :user
      t.string :word
      t.string :guesses

      t.timestamps
    end
  end
end
