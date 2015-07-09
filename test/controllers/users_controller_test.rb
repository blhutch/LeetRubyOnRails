require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

test "should create a registered user" do
    post :create, user: params { user: :fixtures_are_cool).id
    assert_equal(new_user_session_url, @response.headers['Location'])
  end
end