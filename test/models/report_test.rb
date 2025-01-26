# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = FactoryBot.create(:user, :alice)
    @alice_report = FactoryBot.create(:report, user: @alice)
    bob = FactoryBot.create(:user, :bob)
    @bob_report = FactoryBot.create(:report, user: bob)
    @carol = FactoryBot.create(:user, :carol)
    @carol_report = FactoryBot.create(
      :report,
      user: @carol,
      title: 'バグ修正',
      content: "本日行った作業: \nユーザー認証のバクを修正。\nCheck this link: http://localhost:3000/reports/#{@alice_report.id}"
    )
  end

  test 'not update a report without a title' do
    @alice_report.title = nil
    assert_not @alice_report.save
  end

  test 'not update a report without a content' do
    @alice_report.content = nil
    assert_not @alice_report.save
  end

  test '"editable?" by owner' do
    assert @alice_report.editable?(@alice)
  end

  test '"created_on" is as same as the created date' do
    created_day = Date.new(2025, 1, 19)
    @carol_report = FactoryBot.create(:report, user: @carol, created_at: created_day)

    assert_equal created_day, @carol_report.created_on
  end

  test '"save_mentions" creates mentions for valid report links' do
    @alice_report.content = "Check this link: http://localhost:3000/reports/#{@bob_report.id}"
    @alice_report.save

    assert_equal 1, @alice_report.active_mentions.count, 'There should be one active mention'
    assert_includes @alice_report.mentioning_reports, @bob_report
  end

  test '"save_mentions" updates mentions for valid report links' do
    @carol_report.update(content: "本日行った作業: \nユーザー認証のバクを修正。\nCheck this link: http://localhost:3000/reports/#{@bob_report.id}")
    @carol_report.reload

    assert_not_includes @carol_report.mentioning_reports, @alice_report
    assert_includes @carol_report.mentioning_reports, @bob_report
  end

  test '"save_mentions" removes a mention when the report is destroyed' do
    assert_includes @carol_report.mentioning_reports, @alice_report
    @alice_report.destroy
    @carol_report.reload

    assert_not_includes @carol_report.mentioning_reports, @alice_report
  end
end
