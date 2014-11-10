class TictactoeController < ApplicationController

  before do
    authenticate!
  end

  get '/' do
    leader = Win.order(tictactoe: :desc).limit(1)[0]
    leader_id = leader.user_id
    @number_wins = leader.tictactoe.to_s
    leader_user = User.find(leader_id)
    @leader_username = leader_user.username

    erb :'tictactoe/index'
  end

  get '/opponents' do
    opponents = User.where.not(id: current_user.id)
    opponents.to_json
  end

  get '/games' do

    user = User.find(current_user.id)
    games = user.tictactoe_games.where(active?: true)
    game_array = TictactoeGame.create_game_array(games)
    game_array.to_json

  end

  get '/load' do
    game_id = params[:id]
    game = TictactoeGame.find(game_id)
    game_state = game.game_state

    player_state = TttPlayerState.find_by(user_id: current_user.id, tictactoe_game_id: game.id)
    data = {
      status: player_state.status,
      game_state: game_state,
      symbol: player_state.symbol
    }
    data.to_json
  end

  post '/new' do
    db_game_state = TictactoeGame.create_game_state

    game = TictactoeGame.create(game_state: db_game_state, active?: true)

    player = TttPlayerState.create(user_id: current_user.id, tictactoe_game_id: game.id, turn?: true, symbol: 'X')
    TttPlayerState.create(user_id: params[:id], tictactoe_game_id: game.id, turn?: false, symbol: 'O')

    data = {
      game_id: game.id,
      game_state:db_game_state,
      symbol: player.symbol
    }
    data.to_json
  end

  post '/turn' do
    x,y = params[:coords].split(',')
    game = TictactoeGame.find(params[:game_id])
    player_state = TttPlayerState.find_by(user_id: current_user.id, tictactoe_game_id: game.id)
    opponent_state = TttPlayerState.where.not(user_id:current_user).where(tictactoe_game_id: game.id)[0]
    data = TictactoeGame.turn(player_state, opponent_state, game, x, y)
    data.to_json
  end

end