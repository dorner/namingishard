class WordsController < ApplicationController

  def find_word
    Word.find(params[:id])
  end

  def create
    word = Word.create!(word: params[:word])
    redirect_to word_path(word, notice: "Word #{params[:word]} created - add some related words!")
  end

  def show
    @word = find_word
    @relations = WordRelation.ordered_word_relations(@word)
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
