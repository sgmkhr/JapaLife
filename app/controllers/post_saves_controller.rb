class PostSavesController < ApplicationController
  def create
    recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    post_save = current_user.post_saves.new
    post_save.recommend_place_post_id = recommend_place_post.id
    post_save.save
    redirect_to request.referer
  end

  def index
    @saved_posts = current_user.saved_posts
  end

  def destroy
    recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    post_save = current_user.post_saves.find_by(recommend_place_post_id: recommend_place_post.id)
    post_save.destroy
    redirect_to request.referer
  end
end
