class CreateTttPlayerStateTable < ActiveRecord::Migration
  def change
    create_table :ttt_player_states do |t|
      t.references :user
      t.references :tictactoe_game
      t.boolean :turn?

      t.timestamps
    end
  end
end
