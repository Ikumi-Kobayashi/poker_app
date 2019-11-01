require 'test_helper'

class PokerControllerTest < ActionDispatch::IntegrationTest
  test "should get check" do
    get poker_check_url
    assert_response :success
  end

end
