# frozen_string_literal: true

class Report < ApplicationRecord
  after_save :update_mentions
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  has_many :mentions_as_mentioning, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentions_as_mentioning, source: :mentioned_report

  has_many :mentions_as_mentioned, class_name: 'Mention', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentions_as_mentioned, source: :mentioning_report

  private

  def update_mentions
    mentions_as_mentioned.destroy_all

    mentioning_report_ids = content.scan(%r{http://(?:localhost|127\.0\.0\.1):3000/reports/(\d+)}).map(&:first)
    mentioning_report_ids.each do |mentioning_report_id|
      Mention.create(mentioned_report: self, mentioning_report_id:) if Report.exists?(mentioning_report_id)
    end
  end
end
