class HomeController < ApplicationController

  get '/' do
    erb :index
  end

  post '/register' do
    user = User.new(username: params[:username])
    user.password = params[:password]
    user.save!
    Win.create(user_id: user.id)
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.password == params[:password]
      session[:current_user] = user.id
      true.to_json
    else
      false.to_json
    end
  end

  get '/profile' do
    authenticate!
    @user = User.find(current_user.id)
    @wins = Win.find_by(user_id: current_user.id)

    erb :profile
  end

end