require "test_helper"

class PostSavesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get post_saves_index_url
    assert_response :success
  end
end
