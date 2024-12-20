# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  private

  def find_commentable
    Report.find(params[:report_id])
  end
end
