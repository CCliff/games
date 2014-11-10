class HangmanController < ApplicationController

  before do
    authenticate!
  end

  get '/' do
    leader = Win.order(hangman: :desc).limit(1)[0]
    leader_id = leader.user_id
    @number_wins = leader.hangman.to_s
    leader_user = User.find(leader_id)
    @leader_username = leader_user.username
    # @alphabet = ('a'..'z').to_a
    @word = "new"

    erb :'hangman/index'
  end

  get '/new' do
    word = HangmanGame.create_word
    game_state = HangmanGame.get_game_state(word)
    num_guesses = 0
    HangmanGame.find_by(user_id: current_user.id).destroy if HangmanGame.find_by(user_id: current_user.id)
    HangmanGame.create(user_id: current_user.id, word: word, guesses: "", game_state: game_state, num_guesses: num_guesses)

    game_state.to_json
  end

  post '/guess' do
    hash = {}
    gameover = false
    guess = params[:guess]
    game = HangmanGame.find_by(user_id: current_user.id)
    word = game.word
    game_state = game.game_state
    new_game_state = game_state.clone
    user_guesses = game.guesses
    user_guesses = guess + user_guesses
    num_guesses = game.num_guesses

    num_guesses = HangmanGame.count_guesses(word, guess, num_guesses)

    index_array = HangmanGame.create_index_array(word, guess)

    index_array.each do |index|
      new_game_state[index] = guess
    end

    gameover = HangmanGame.check_status(new_game_state, word, num_guesses, current_user.id)

    game.update(guesses: user_guesses, game_state: new_game_state, num_guesses: num_guesses)

    hash = {game_state: new_game_state, gameover: gameover, word: word, turn: num_guesses}.to_json
  end

end