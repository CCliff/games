class HangmanController < ApplicationController

  get '/' do
    @alphabet = ('a'..'z').to_a
    @word = "new"
    erb :'hangman/index'
  end

  get '/new' do
    word = HangmanGame.create_word
    game_state = ""
    word.length.times do
      game_state << "_"
    end
    num_guesses = 0
# ******NEED TO REPLACE user_id: WITH current_user *******
    HangmanGame.find_by(user_id: 1).destroy
    HangmanGame.create(user_id: 1, word: word, guesses: "", game_state: game_state, num_guesses: num_guesses)
    game_state.to_json
  end

  post '/guess' do
    hash = {}
    gameover = false
    guess = params[:guess]
# ******NEED TO REPLACE user_id: WITH current_user *******
    game = HangmanGame.find_by(user_id: 1)
    word = game.word
    game_state = game.game_state
    new_game_state = game_state.clone
    user_guesses = game.guesses
    user_guesses = guess + user_guesses
    num_guesses = game.num_guesses

    unless word.include? guess
      num_guesses += 1
    end

    i=0
    index_array = []
    while i < word.length
      if guess == word[i]
        index_array << i
      end
      i += 1
    end

    index_array.each do |index|
      new_game_state[index] = guess
    end

    if new_game_state == word
      gameover = "win"
    elsif num_guesses == 6
      gameover = "lose"
    end

    game.update(guesses: user_guesses, game_state: new_game_state, num_guesses: num_guesses)

    hash = {game_state: new_game_state, gameover: gameover, word: word, turn: num_guesses}.to_json
  end

end