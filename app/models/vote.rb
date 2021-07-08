class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :word_relation
end
