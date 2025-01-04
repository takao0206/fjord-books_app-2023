class AddUniqueIndexToMentions < ActiveRecord::Migration[7.0]
  def change
    add_index :mentions, %i[mentioned_report_id mentioning_report_id], unique: true
  end
end
