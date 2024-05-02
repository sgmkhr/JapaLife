class PostCommentsController < ApplicationController
  def create
    @recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.recommend_place_post_id = @recommend_place_post.id
    @post_comment.save
    redirect_to request.referer
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @recommend_place_post = RecommendPlacePost.find(params[:recommend_place_post_id])
    redirect_to request.referer
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:content)
  end
end
