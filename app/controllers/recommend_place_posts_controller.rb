class RecommendPlacePostsController < ApplicationController
  before_action :ensure_matching_author, only: [:edit, :update, :destroy]

  def new
    @recommend_place_post = RecommendPlacePost.new
    @prefectures = RecommendPlacePost.prefectures
  end

  def create
    @recommend_place_post = current_user.recommend_place_posts.new(recommend_place_post_params)
    if @recommend_place_post.save
      redirect_to recommend_place_post_path(@recommend_place_post.id), notice: '新規投稿されました。'
    else
      render :new
    end
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    if params[:latest]
      @recommend_place_posts = RecommendPlacePost.latest
    elsif params[:old]
      @recommend_place_posts = RecommendPlacePost.old
    else
      @recommend_place_posts = RecommendPlacePost.all.sort { |a,b|
        b.favorites.where(created_at: from...to).size <=>
        a.favorites.where(created_at: from...to).size
      }
    end
    @prefectures = RecommendPlacePost.prefectures
  end

  def show
    @recommend_place_post = RecommendPlacePost.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @recommend_place_post = RecommendPlacePost.find(params[:id])
    @prefectures = RecommendPlacePost.prefectures
  end

  def update
    recommend_place_post = RecommendPlacePost.find(params[:id])
    if recommend_place_post.update(recommend_place_post_params)
      redirect_to recommend_place_post_path(recommend_place_post.id), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    RecommendPlacePost.find(params[:id]).destroy
    redirect_to recommend_place_posts_path, notice: '投稿を削除しました。'
  end

  private

  def recommend_place_post_params
    params.require(:recommend_place_post).permit(:name, :caption, :introduction, :post_image).merge(prefecture: params[:recommend_place_post][:prefecture].to_i)
  end

  def ensure_matching_author
    unless current_user.id == RecommendPlacePost.find(params[:id]).user_id
      redirect_to recommend_place_posts_path, caution: '他人の投稿は編集できません。'
    end
  end
end
