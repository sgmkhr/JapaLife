class CommentFavoritesController < ApplicationController
  def create
    @recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    @post_comment = PostComment.find(params[:post_comment_id])
    @post_comment.recommend_place_post_id = @recommend_place_post.id
    comment_favorite = current_user.comment_favorites.new(post_comment_id: @post_comment.id)
    comment_favorite.save
  end

  def destroy
    @recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    @post_comment = PostComment.find(params[:post_comment_id])
    @post_comment.recommend_place_post_id = @recommend_place_post.id
    comment_favorite = current_user.comment_favorites.find_by(post_comment_id: @post_comment.id)
    comment_favorite.destroy
  end
end
