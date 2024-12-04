# frozen_string_literal: true

module CommentsHelper
  def new_comment_for(commentable)
    current_user.comments.build(commentable:)
  end
end
