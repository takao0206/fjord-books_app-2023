# frozen_string_literal: true

class Books::CommentsController < CommentsController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash[:alert] = @comment.errors.full_messages.first
      @book = @commentable
      render 'books/show', status: :unprocessable_entity
    end
  end

  private

  def find_commentable
    Book.find(params[:book_id])
  end
end
