# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'i18n_pluralize returns word' do
    I18n.locale = :ja
    assert_equal '本', i18n_pluralize('本')
    I18n.locale = :en
    assert_equal 'books', i18n_pluralize('book')
  end

  test 'i18n_error_count formats error count' do
    I18n.locale = :ja
    assert_equal '3件のエラー', i18n_error_count(3)
    I18n.locale = :en
    assert_equal '3 errors', i18n_error_count(3)
  end

  test 'format_content with <br>' do
    content = "Line 1\nLine 2\nLine 3"
    expected = 'Line 1<br>Line 2<br>Line 3'
    assert_dom_equal expected, format_content(content)
  end
end
