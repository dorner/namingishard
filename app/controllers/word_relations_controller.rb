class WordRelationsController < ApplicationController
  def vote
    rel = WordRelation.find(params[:id])
    vote = Vote.find_or_initialize_by(word_relation_id: rel.id, user_id: current_user.id)
    vote.score = params[:score]
    vote.save!
    rel.reload
    render json: { score: rel.vote_score, count: rel.vote_count }
  end

end
