# frozen_string_literal: true

class Books::CommentsController < CommentsController
  private

  def find_commentable
    @commentable = Book.find(params[:book_id])
  end

  def set_commentable
    @book = @commentable
  end

  def template_for_show
    'books/show'
  end
end
