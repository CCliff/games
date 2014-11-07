class TictactoeController < ApplicationController

  get '/' do
    erb :'tictactoe/index'
  end

  get '/new' do
    game = TictactoeGame.find_by(user_1: 1, user_2: 2)
    game.destroy if game
    game_state = [[0,0,0],[0,0,0],[0,0,0]]
    db_game_state = game_state.flatten.join('')
    TictactoeGame.create(user_1: 1, user_2: 2, game_state: db_game_state)
  end

  post '/turn' do
    x,y = params[:coords].split(',')
    game = TictactoeGame.find_by(user_1: 1, user_2: 2)
    new_game_state = game.game_state.split('').each_slice(3).to_a
    new_game_state[y.to_i][x.to_i] = 'X'
    gameover = TictactoeGame.check_status(new_game_state)
    new_db_game_state = new_game_state.flatten.join('')
    game.update(game_state: new_db_game_state)
    "X".to_json
  end

end