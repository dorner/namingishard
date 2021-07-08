class WordRelation < ApplicationRecord
  belongs_to :word1, class_name: 'Word', primary_key: :word, foreign_key: :word1
  belongs_to :word2, class_name: 'Word', primary_key: :word, foreign_key: :word2
  has_many :votes, dependent: :delete_all

  # @param word [Word]
  # @return [Word]
  def other_word(word)
    self.word1 == word ? self.word2 : self.word1
  end

  # @param word [Word]
  # @param new_word [String]
  def self.add_relation(word, new_word)
    new_word_record = Word.find_or_create_by!(word: new_word)
    self.create!(word1: word, word2: new_word_record)
  end

  # @return [Integer]
  def vote_count
    self.votes.count
  end

  # @return [Float]
  def vote_score
    self.votes.average(:score)
  end

  # @param word [Word]
  # @return [ActiveRecord::Relation]
  def self.ordered_word_relations(word)
    sql = <<-SQL
      select word_relations.*, AVG(votes.score) AS vote_avg, COUNT(votes.id) AS vote_count,
             (sum(votes.score) + 25.0) / (count(votes.id) + 20.0) as score
          from word_relations
          left join votes on votes.word_relation_id = word_relations.id
          where word_relations.word1 = ? OR word_relations.word2 = ?
      group by word_relations.id
      order by score desc, count(votes.id) desc
    SQL
    WordRelation.find_by_sql([sql, word.word, word.word])
  end


end
