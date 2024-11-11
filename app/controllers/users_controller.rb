# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show; end

  def edit
    if current_user == @user
      redirect_to edit_user_registration_path
    else
      flash[:alert] = '編集できません。編集したいユーザーでログインし直してください。'
      redirect_to user_path(@user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
