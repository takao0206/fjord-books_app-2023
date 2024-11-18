# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validate :avatar_format

  private

  def avatar_format
    return unless avatar.attached?

    allowed_types = ['image/jpg', 'image/png', 'image/gif']
    return unless avatar.content_type.nil? || !allowed_types.include?(avatar.content_type)

    errors.add(:avatar, :invalid)
    avatar.purge
  end
end
