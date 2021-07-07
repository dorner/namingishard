class SearchController < ApplicationController
  def index
    if params[:word].blank?
      redirect_to '/', notice: 'Please enter a word to search!'
    end
    # exact match
    word = Word.find_by_word(params[:word])
    redirect_to word_path(word) and return if word
    @words = Word.where('word <% ?', "%#{params[:word]}%").limit(20)
  end
end
