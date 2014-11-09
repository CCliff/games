class AddStatusToTttPlayerStatus < ActiveRecord::Migration
  def change
    add_column :ttt_player_states, :status, :string
  end
end
