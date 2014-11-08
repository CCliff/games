class AddSymbolColumnToTttPlayerState < ActiveRecord::Migration
  def change
    add_column :ttt_player_states, :symbol, :string
  end
end
