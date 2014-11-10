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
    # @alphabet = ('a'..'z').to_a
    @word = "new"
    erb :'tictactoe/index'
  end

  get '/opponents' do
    opponents = User.where.not(id: current_user.id)
    opponents.to_json
  end

  get '/games' do

    user = User.find(current_user.id)
    games = user.tictactoe_games.where(active?: true)
    game_array = []
    games.map do  |game|
      game_array << game.id
    end
    game_array.to_json

  end

  get '/load' do
    data = []
    game_id = params[:id]
    game = TictactoeGame.find(game_id)
    game_state = game.game_state

    player_state = TttPlayerState.find_by(user_id: current_user.id, tictactoe_game_id: game.id)
    data << player_state.status
    data << game_state
    data.to_json
  end

  post '/new' do
    game_state = [[0,0,0],[0,0,0],[0,0,0]]
    db_game_state = game_state.flatten.join('')
    game = TictactoeGame.create(game_state: db_game_state, active?: true)

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
      if gameover == 'X' || gameover == 'O'
        player_state.update(status: 'won')
        opponent_state.update(status: 'loss')
        game.update(active?: false)
        win = Win.find_by(user_id: current_user.id)
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

      data << gameover
      data << new_db_game_state
      data << player_state.status
      data.to_json
    else

    end
  end

end