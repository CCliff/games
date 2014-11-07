class TictactoeGame < ActiveRecord::Base

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
        if column.uniq.length == 1 && column[0] != "0"
          return column[0]
        end
      end
    end

    #check diags

    if (game_state[0][0] == game_state[1][1] && game_state[1][1] == game_state[2][2]) || (game_state[0][2] == game_state[1][1] && game_state[1][1] == game_state[0][2]) && game_state[1][1] != "0"
      return game_state[1][1]
    end

    #check for tie

    unless game_state.flatten.incude?("0")
      return "tie"
    end

  end

end