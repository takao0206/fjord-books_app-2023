# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:apple)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'visiting the index' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    click_on '本の新規作成'

    fill_in 'タイトル', with: 'バナナの本'
    fill_in 'メモ', with: 'バナナのメモ'
    fill_in '著者', with: 'Alice'
    click_button '登録する'

    assert_text '本が作成されました。'
    assert_text 'バナナの本'
    assert_text 'バナナのメモ'
    assert_text 'Alice'
    click_on '本の一覧に戻る'
  end

  test 'should update Book' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit book_url(@book)
    click_on 'この本を編集', match: :first

    fill_in 'タイトル', with: 'チェリーの本'
    fill_in 'メモ', with: 'チェリーのメモ'
    fill_in '著者', with: 'Bob'
    click_button '更新する'

    assert_text '本が更新されました。'
    assert_text 'チェリーの本'
    assert_text 'チェリーのメモ'
    assert_text 'Bob'
    click_on '本の一覧に戻る'
  end

  test 'should destroy Book' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit book_url(@book)
    click_button 'この本を削除', match: :first

    assert_text '本が削除されました。'
  end
end
