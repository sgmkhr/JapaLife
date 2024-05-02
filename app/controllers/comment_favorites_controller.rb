class CommentFavoritesController < ApplicationController
  def create
    post_comment = PostComment.find(params[:post_comment_id])
    comment_favorite = current_user.comment_favorites.new(post_comment_id: post_comment.id)
    comment_favorite.save
    redirect_to request.referer
  end
  
  def destroy
    post_comment = PostComment.find(params[:post_comment_id])
    comment_favorite = current_user.comment_favorites.find_by(post_comment_id: post_comment.id)
    comment_favorite.destroy
    redirect_to request.referer
  end
end
