# frozen_string_literal: true

class Books::CommentsController < CommentsController
  private

  def find_commentable
    Book.find(params[:book_id])
  end

  def set_commentable
    @book = find_commentable
  end

  def template_for_show
    'books/show'
  end
end
