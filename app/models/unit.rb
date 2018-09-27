class Unit < ApplicationRecord
  before_create :generate_uuid

  belongs_to :course, required: false

  validates :title, presence: true
  validates :embed_code, presence: true
  validates :description, presence: true
  validates :duration, presence: true
  validates :avatar, presence: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  do_not_validate_attachment_file_type :avatar

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
