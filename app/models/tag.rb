class Tag < ApplicationRecord
  belongs_to :word, primary_key: :word, foreign_key: :word
end
