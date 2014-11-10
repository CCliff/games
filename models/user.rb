require 'bcrypt'
class User < ActiveRecord::Base
  has_many :ttt_player_states
  has_many :tictactoe_games, :through => :ttt_player_states
  has_one :win

  validates :username, uniqueness: true
  include BCrypt

  def password
    Password.new(self.hashed_password)
  end

  def password=(new_password)
      self.hashed_password = Password.create(new_password)
  end
end