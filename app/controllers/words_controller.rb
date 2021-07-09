class WordsController < ApplicationController

  rescue_from ActiveRecord::RecordNotUnique do
    redirect_back(fallback_location: '/', alert: 'The word already exists!')
  end

  def find_word
    Word.find(params[:id])
  end

  def create
    if ProfanityChecker.check(params[:word])
      redirect_back(fallback_location: '/', alert: 'Your word was flagged by our profanity checker! Please try a different one.')
    else
      word = Word.create!(word: params[:word])
      redirect_to word_path(word, notice: "Word #{params[:word]} created - add some related words!")
    end
  end

  def show
    @word = find_word
    @relations = WordRelation.ordered_word_relations(@word)
    @secondary_relations = if @relations.any?
                             WordRelation.second_order_relations(
                               @relations.map { |r| r.other_word(@word)}, @word
                             )
                           else
                             []
                           end
  end

  def add_related_word
    this_word = find_word
    WordRelation.add_relation(this_word, params[:new_word])
    redirect_back(fallback_location: word_path(this_word),
                  notice: "#{this_word.word} and #{params[:new_word]} are now related!")
  end

  def update
    word = find_word
    description = params[:word][:description]
    word.update!(description: description)
    redirect_back(fallback_location: word_path(word))
  end

end
