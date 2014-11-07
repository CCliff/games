require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :host => '',
  :adapter  => "postgresql",
  :database => "games_db"
)

ROOT_PATH = Dir.pwd
Dir[ROOT_PATH+"/helpers/*.rb"].each do |file|
  require file
  puts "requiring #{file}"
end
Dir[ROOT_PATH+"/models/*.rb"].each do |file|
  require file
  puts "requiring #{file}"
end
Dir[ROOT_PATH+"/controllers/*.rb"].each do |file|
  require file
  puts "requiring #{file}"
end

map('/'){ run HomeController }
map('/hangman'){ run HangmanController }
map('/tictactoe'){ run TictactoeController }