class Word < ApplicationRecord

  self.primary_key = :word
  has_many :word_relations, foreign_key: :word1, primary_key: :word

end
