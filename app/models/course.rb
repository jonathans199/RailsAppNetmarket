class Course < ApplicationRecord
  before_create :generate_uuid

  has_many   :units, dependent: :destroy
  belongs_to :category, class_name: 'Category', primary_key: 'code', foreign_key: 'category_id', required: false

  validates :title, presence: true
  validates :category_id, presence: true
  validates :description, presence: true
  validates :language, presence: true
  # validates :avatar, presence: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/img/online-education.svg'
  do_not_validate_attachment_file_type :avatar

  private
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
