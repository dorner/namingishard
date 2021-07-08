class TagsController < ApplicationController
  def create
    word = Word.find_by_word(params[:word])
    head 422 and return unless word
    Tag.create(word: word, tag: params[:tag])
    head :ok
  end

  def delete_tag
    word = Word.find_by_word(params[:word])
    head 422 and return unless word
    Tag.where(word: word, tag: params[:tag]).first.destroy
    head :ok
  end
end
