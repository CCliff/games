class CreateWinsTable < ActiveRecord::Migration
  def change
    create_table :wins do |t|
      t.references :user
      t.integer :tictactoe, default: 0
      t.integer :hangman, default: 0
    end
  end
end
