# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  def setup
    alice = FactoryBot.create(:user, :alice)
    bob = FactoryBot.create(:user, :bob)
    @alice_report = FactoryBot.create(:report, :alice, user: alice)
    @bob_report = FactoryBot.create(:report, :bob, user: bob)
    @alice_mention = FactoryBot.create(:report_mention, mentioning: @bob_report, mentioned: @alice_report)
  end

  test 'have valid belongings' do
    assert_equal @alice_report, @alice_mention.mentioned
    assert_equal @bob_report, @alice_mention.mentioning
  end

  test 'not duplicate mentions' do
    duplicate_mention = ReportMention.new(mentioning: @bob_report, mentioned: @alice_report)
    assert_not duplicate_mention.valid?
  end
end
