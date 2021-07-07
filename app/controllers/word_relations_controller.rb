class WordRelationsController < ApplicationController
  def vote
    rel = WordRelation.find(params[:id])
    field = params[:direction] == 'up' ? 'up_votes' : 'down_votes'
    id = WordRelation.connection.quote(params[:id])
    rows = WordRelation.connection.
      update("UPDATE word_relations SET #{field} = #{field} + 1 where id=#{id}")
    second_rel = WordRelation.where(word1: rel.word2, word2: rel.word1).first
    rows += WordRelation.connection.
      update("UPDATE word_relations SET #{field} = #{field} + 1 where id=#{second_rel.id}")
    render status: :unprocessable_entity and return if rows < 2
    render plain: rel.reload.send(field)
  end

end
