# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
  end

  test 'user has many reports' do
    assert_respond_to @alice, :reports
  end

  test 'user has many comments' do
    assert_respond_to @alice, :comments
  end

  test 'avatar resize direction is limit: [150, 150]' do
    avatar = Rails.root.join('test/fixtures/files/avatar.jpeg').open
    @alice.avatar.attach(io: avatar, filename: 'avatar.jpeg', content_type: 'image/jpeg')

    resize_to_limit = @alice.avatar.variant(:thumb).variation.transformations[:resize_to_limit]
    assert_equal [150, 150], resize_to_limit
  end

  test 'name or email' do
    @bob = User.new(email: 'bob@example.com')
    assert_equal 'bob@example.com', @bob.name_or_email

    @bob.name = 'Bob'
    assert_equal 'Bob', @bob.name_or_email
  end
end
