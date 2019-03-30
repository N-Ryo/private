require 'test_helper'

class DirectMessageTest < ActiveSupport::TestCase
  def setup
    @direct_message = DirectMessage.new(message:"hello",
                          from_id: users(:michael).id, to_id: users(:lana).id)
  end

  test "should be valid" do
    assert @direct_message.valid?
  end

  test "message should be present" do
    @direct_message.message = "   "
    assert_not @direct_message.valid?
  end

  test "message should be at most 140 characters" do
    @direct_message.message = "a" * 141
    assert_not @direct_message.valid?
  end

  test "should require a from_id " do
    @direct_message.from_id = nil
    assert_not @direct_message.valid?
  end

  test "should require a to_id " do
    @direct_message.to_id = nil
    assert_not @direct_message.valid?
  end

end
