class HangmanGame < ActiveRecord::Base

  def self.create_word
    RandomWord.exclude_list << /_/
    [RandomWord.adjs.next, RandomWord.nouns.next].sample
  end

end