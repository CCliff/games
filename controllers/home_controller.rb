class HomeController < ApplicationController

  get '/' do
    erb :index
  end

  post '/register' do
    user = User.new(username: params[:username])
    user.password = params[:password]
    user.save!
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

end