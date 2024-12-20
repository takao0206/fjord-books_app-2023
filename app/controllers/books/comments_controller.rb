# frozen_string_literal: true

class Books::CommentsController < CommentsController
  private

  def find_commentable
    Book.find(params[:book_id])
  end
end
