class TictactoeController < ApplicationController

  get '/' do
    erb :'tictactoe/index'
  end

  get '/opponents' do
    opponents = User.where.not(id: current_user.id)
    opponents.to_json
  end

  get '/games' do
    opponents = TictactoeGame.joins('JOIN users u on u.id = tictactoe_games.user_1 OR u.id = tictactoe_games.user_2').where("user_1 = ? OR user_2 = ?" ,current_user.id, current_user.id)
    opponent_array = []
    opponents.uniq.each do |opponent|
      if opponent.user_1 == current_user.id
        opp_id = opponent.user_2
      elsif opponent.user_2 == current_user.id
        opp_id = opponent.user_1
      else
        opp_id = "Something went wrong..."
      end
      opponent_array << [User.find(opp_id), opponent]
    end
    opponent_array.to_json
  end

  get '/load' do
    game_id = params[:id]
    game = TictactoeGame.find(game_id)
    game_state = game.game_state
    game_state.to_json
  end

  post '/new' do
    game = TictactoeGame.find_by(user_1: current_user.id, user_2: params[:id])
    game.destroy if game
    game_state = [[0,0,0],[0,0,0],[0,0,0]]
    db_game_state = game_state.flatten.join('')
    TictactoeGame.create(user_1: current_user.id, user_2: params[:id], game_state: db_game_state)
  end

  post '/turn' do
    x,y = params[:coords].split(',')
    game = TictactoeGame.find_by(user_1: current_user.id, user_2: params[:opponent_id])
      new_game_state = game.game_state.split('').each_slice(3).to_a
      if current_user.id = game.user_1

        new_game_state[y.to_i][x.to_i] = 'X'
        gameover = TictactoeGame.check_status(new_game_state)
        new_db_game_state = new_game_state.flatten.join('')
        game.update(game_state: new_db_game_state, last_move:current_user.id)
        "X".to_json
      else
        new_game_state[y.to_i][x.to_i] = 'O'
        gameover = TictactoeGame.check_status(new_game_state)
        new_db_game_state = new_game_state.flatten.join('')
        game.update(game_state: new_db_game_state)
        "O".to_json
      end

    end

end