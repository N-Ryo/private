require 'test_helper'

class DirectMessageCommunicationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @follow_user = users(:lana)
    @unfollow_user =users(:archer)
    log_in_as(@user)
  end

  test "valid direct message page" do
    assert @follow_user.activated?
    assert @user.active_relationships.find_by(followed_id: @follow_user.id).valid?
    get direct_messages_path(@follow_user)
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'DirectMessage.count', 1 do
      post direct_messages_path, params: { direct_message: {
                                        to_id: @follow_user.id,
                                        message: "Hello",
                                        picture: picture} }

    end
  end

end
