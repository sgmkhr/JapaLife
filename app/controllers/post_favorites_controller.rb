class PostFavoritesController < ApplicationController
  def create
    recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    post_favorite = current_user.post_favorites.new(recommend_place_post_id: recommend_place_post.id)
    post_favorite.save
    redirect_to request.referer
  end
  
  def destroy
    recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    post_favorite = current_user.post_favorites.find_by(recommend_place_post_id: recommend_place_post.id)
    post_favorite.destroy
    redirect_to request.referer
  end
end
