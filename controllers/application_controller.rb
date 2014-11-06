class ApplicationController < Sinatra::Base

  enable :sessions
  enable :method_override

  helpers Sinatra::AuthenticationHelper

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

end