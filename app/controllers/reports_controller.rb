# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy]
  before_action :check_report_owner, only: %i[edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def show
    @comment = current_user.comments.build(commentable: @report)
  end

  def new
    @report = current_user.reports.build
  end

  def edit; end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!
    redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  rescue ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = e.message
    @comment = Comment.new
    render :show, status: :unprocessable_entity
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def check_report_owner
    return if @report.user == current_user

    redirect_to reports_path
  end
end
