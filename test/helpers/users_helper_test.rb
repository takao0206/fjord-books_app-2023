# frozen_string_literal: true

require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  setup do
    @user = FactoryBot.create(:user, :alice)
  end

  test 'current_user_name returns value' do
    assert_equal 'Alice', current_user_name(@user)
    @user.name = nil
    assert_equal 'alice@example.com', current_user_name(@user)
    @user.email = nil
    assert_nil current_user_name(@user)
  end
end
