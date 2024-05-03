class SearchesController < ApplicationController
  def new
    @prefectures = RecommendPlacePost.prefectures
  end
  
  def search
    @model = params[:model]
    @method = params[:method]
    @content = params[:content]
    if @model == 'user'
      @role = params[:role]
      @records = User.search_for(@content, @method, @role)
    else
      @subject = params[:subject]
      @prefecture = params[:prefecture]
      @records = RecommendPlacePost.search_for(@content, @method, @prefecture, @subject)
    end
  end
end
