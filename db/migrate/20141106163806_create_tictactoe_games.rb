class CreateTictactoeGames < ActiveRecord::Migration
  def change
    create_table :tictactoe_games do |t|
      t.integer :user_1
      t.integer :user_2
      t.string :game_state
      t.string :last_move

      t.timestamps
    end
  end
end
