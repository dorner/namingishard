class Word < ApplicationRecord

  self.primary_key = :word
  has_many :word_relations, foreign_key: :word1, primary_key: :word
  has_many :related_words, class_name: 'Word',
           through: :word_relations, source: :word2

  # @return [ActiveRecord::Relation]
  def ordered_word_relations
    self.word_relations.select('id, word1, word2, up_votes, down_votes, up_votes - down_votes AS total_votes').
      order('total_votes DESC')
  end
end
