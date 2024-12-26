# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  private

  def find_commentable
    Report.find(params[:report_id])
  end

  def set_commentable
    @report = find_commentable
  end

  def template_for_show
    'reports/show'
  end
end
