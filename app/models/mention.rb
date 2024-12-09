# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioned_report, class_name: 'Report', inverse_of: :mentions_as_mentioned
  belongs_to :mentioning_report, class_name: 'Report', inverse_of: :mentions_as_mentioning
end
