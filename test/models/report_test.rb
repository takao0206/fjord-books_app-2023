# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @alice = users(:alice)
    @alice_report = reports(:alice)
    @bob_report = reports(:bob)
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
    assert_equal @alice_report.created_at.to_date, @alice_report.created_on
  end

  test '"save_mentions" creates mentions for valid report links' do
    @alice_report.content = "Check this link: http://localhost:3000/reports/#{@bob_report.id}"
    @alice_report.save

    assert_equal 1, @alice_report.active_mentions.count, 'There should be one active mention'
    assert_includes @alice_report.mentioning_reports, @bob_report
  end
end
