# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: %i[create edit update]
  before_action :set_comment, only: %i[edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      flash[:alert] = @comment.errors.full_messages.first
      set_commentable
      render template_for_show, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @commentable = @comment.commentable

    begin
      @comment.destroy!
      redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    rescue ActiveRecord::RecordNotDestroyed => e
      flash[:alert] = e.message
      set_commentable
      @comment = Comment.new
      render template_for_show, status: :unprocessable_entity
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user!
    return if @comment.user == current_user

    redirect_to root_path
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    raise NotImplementedError, "#{__method__} メソッドは子クラスで実装してください。"
  end

  def set_commentable
    raise NotImplementedError, "#{__method__} メソッドは子クラスで実装してください。"
  end

  def template_for_show
    raise NotImplementedError, "#{__method__} メソッドは子クラスで実装してください。"
  end
end
