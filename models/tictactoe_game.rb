class TictactoeGame < ActiveRecord::Base

  has_many :ttt_player_states
  has_many :users, :through => :ttt_player_states

  def self.turn(player_state, opponent_state, game, x, y)
    if player_state.turn? == true
      new_game_state = game.game_state.split('').each_slice(3).to_a
      if new_game_state[y.to_i][x.to_i] == '0'
        new_game_state[y.to_i][x.to_i] = player_state.symbol
        gameover = TictactoeGame.check_status(new_game_state)
        if gameover == 'X' || gameover == 'O'
          player_state.update(status: 'won')
          opponent_state.update(status: 'loss')
          game.update(active?: false)
          win = Win.find_by(user_id: player_state.user_id)
          tictactoe_wins = win.tictactoe
          win.update(tictactoe: tictactoe_wins + 1)
        elsif gameover == 'tie'
          player_state.update(status: 'tie')
          opponent_state.update(status: 'tie')
          game.update(active?: false)
        else
          opponent_state.update(turn?: true)
        end
        player_state.update(turn?: false)
        new_db_game_state = new_game_state.flatten.join('')
        game.update(game_state: new_db_game_state)

        data = {
          game_state: new_db_game_state,
          status: player_state.status
        }

      end
    else
      data = 'exists'
    end
  end

  def self.create_game_state
    game_state = [[0,0,0],[0,0,0],[0,0,0]]
    game_state.flatten.join('')
  end

  def self.create_game_array(games)
    game_array = []
    games.each do |game|
      game_array << game.id
    end
    game_array
  end

  def self.check_status(game_state)
    # check if any row is won
    game_state.each do |row|
      if row.uniq.length == 1 && row[0] != "0"
        return row[0]
      end
    end

    # check if any column is won
    i=0
    while i < 3
      column = []
      game_state.map do |row|
        column << row[i]
      end
      if column.uniq.length == 1 && column[0] != "0"
        return column[0]
      end
      i += 1
    end

    #check diags

    if (game_state[0][0] == game_state[1][1] && game_state[1][1] == game_state[2][2]) || (game_state[0][2] == game_state[1][1] && game_state[1][1] == game_state[2][0]) && game_state[1][1] != "0"
      return game_state[1][1]
    end

    #check for tie

    unless game_state.flatten.include?("0")
      return "tie"
    end

  end

end