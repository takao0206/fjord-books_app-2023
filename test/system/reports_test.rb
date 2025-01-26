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

    fill_in 'タイトル', with: 'プログラミング初心者としての一歩'
    fill_in '内容', with: "今日は初めてプログラミングに触れ、\n基本的な概念を学びました。\n変数やデータ型、簡単な演算子を使って、\n最初のプログラムを作成しました。"
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'プログラミング初心者としての一歩'
    assert_match(/今日は初めてプログラミングに触れ、\s基本的な概念を学びました。\s変数やデータ型、簡単な演算子を使って、\s最初のプログラムを作成しました。/, page.text)
    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: '変数と条件分岐の理解を深める'
    fill_in '内容', with: "昨日学んだ変数に加えて、\n条件分岐を使って簡単なプログラムを作成しました。"
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '変数と条件分岐の理解を深める'
    assert_match(/昨日学んだ変数に加えて、\s条件分岐を使って簡単なプログラムを作成しました。/, page.text)
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

    fill_in 'タイトル', with: '参考になったページを紹介'
    fill_in '内容', with: "以下の日報がエラーメッセージの参考になりました。\nhttp://localhost:3000/reports/#{@mentioning_report.id}"
    click_on '更新する'

    visit report_url(@mentioning_report)
    assert_text 'RailsでCRUD機能を実装'
    click_on '日報の一覧に戻る'
  end
end
