require "test_helper"

class RecommendPlacePostsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get recommend_place_posts_new_url
    assert_response :success
  end

  test "should get index" do
    get recommend_place_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get recommend_place_posts_show_url
    assert_response :success
  end

  test "should get edit" do
    get recommend_place_posts_edit_url
    assert_response :success
  end
end
