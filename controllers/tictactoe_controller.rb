class TictactoeController < ApplicationController

  get '/' do
    erb :'tictactoe/index'
  end

  get '/opponents' do
    opponents = User.where.not(id: current_user.id)
    opponents.to_json
  end

  get '/games' do

    user = User.find(current_user.id)
    games = user.tictactoe_games
    game_array = []
    games.map do  |game|
      game_array << game.id
    end
    game_array.to_json

  end

  get '/load' do
    game_id = params[:id]
    game = TictactoeGame.find(game_id)
    game_state = game.game_state

    game_state.to_json
  end

  post '/new' do
    game_state = [[0,0,0],[0,0,0],[0,0,0]]
    db_game_state = game_state.flatten.join('')
    game = TictactoeGame.create(game_state: db_game_state)

    TttPlayerState.create(user_id: current_user.id, tictactoe_game_id: game.id, turn?: true, symbol: 'X')
    TttPlayerState.create(user_id: params[:id], tictactoe_game_id: game.id, turn?: false, symbol: 'O')

    data = [game.id, db_game_state]
    data.to_json
  end

  post '/turn' do
    data =[]
    x,y = params[:coords].split(',')
    game = TictactoeGame.find(params[:game_id])
    player_state = TttPlayerState.find_by(user_id: current_user.id, tictactoe_game_id: game.id)
    opponent_state = TttPlayerState.where.not(user_id:current_user).where(tictactoe_game_id: game.id)[0]
    if player_state.turn? == true
      new_game_state = game.game_state.split('').each_slice(3).to_a
      new_game_state[y.to_i][x.to_i] = player_state.symbol
      gameover = TictactoeGame.check_status(new_game_state)
      new_db_game_state = new_game_state.flatten.join('')
      game.update(game_state: new_db_game_state)
      player_state.update(turn?: false)
      opponent_state.update(turn?: true)
      data << gameover
      data << new_db_game_state
      data.to_json
    else

    end
  end

end