class WordRelation < ApplicationRecord
  belongs_to :word1, class_name: 'Word', primary_key: :word, foreign_key: :word1
  belongs_to :word2, class_name: 'Word', primary_key: :word, foreign_key: :word2

  # @param word [Word]
  # @param new_word [String]
  def self.add_relation(word, new_word)
    new_word_record = Word.find_or_create_by!(word: new_word)
    self.create!(word1: word, word2: new_word_record)
    self.create!(word1: new_word_record, word2: word)
  end

end
