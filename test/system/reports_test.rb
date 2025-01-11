# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @carol = FactoryBot.create(:user, :carol)
    @dave = FactoryBot.create(:user, :dave)
    @report = FactoryBot.create(:report, user: @carol)
    @mentioning_report = FactoryBot.create(:report, user: @dave)

    visit root_url
    fill_in 'Eメール', with: 'carol@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'Carolの日報'
    fill_in '内容', with: 'Carolの初めての日報'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'Carolの日報'
    assert_text 'Carolの初めての日報'
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: 'Carolの日報'
    fill_in '内容', with: 'Carolの日報の更新内容'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'Carolの日報'
    assert_text 'Carolの日報の更新内容'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    click_on 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
  end

  test 'should create mention' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: 'Carolの日報'
    fill_in '内容', with: "http://localhost:3000/reports/#{@mentioning_report.id}"
    click_on '更新する'

    visit report_url(@mentioning_report)
    assert_text 'Carolの日報'
    click_on '日報の一覧に戻る'
  end
end
