# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  def setup
    @alice_report = reports(:alice)
    @bob_report = reports(:bob)
    @alice_mention = report_mentions(:alice)
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
