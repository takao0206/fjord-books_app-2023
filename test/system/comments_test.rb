# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  setup do
    @carol = FactoryBot.create(:user, :carol)
    @report = FactoryBot.create(:report, user: @carol)
    @comment = FactoryBot.create(:comment, user: @carol, commentable: @report)

    visit root_url
    fill_in 'Eメール', with: @carol.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test 'should create comment' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    fill_in 'comment_content', with: 'Carolのコメント'
    click_on 'コメントする'
    assert_text 'コメントが作成されました。'
    assert_text 'Carolのコメント'
    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    # ログイン後のページ遷移完了を待つため
    assert_css 'h1', text: '本の一覧'

    visit report_url(@report)
    assert_text 'Test comment'

    accept_confirm do
      click_on '削除', match: :first
    end

    assert_text 'コメントが削除されました。'
    assert_no_text 'Test comment'
  end
end
