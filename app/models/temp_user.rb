# == Schema Information
#
# Table name: temp_users
#
#  id                   :integer          not null, primary key
#  name                 :string
#  last_name            :string
#  username             :string
#  email                :string
#  password_digest      :string
#  phone                :string
#  document             :string
#  last_login           :datetime
#  uuid                 :string
#  country              :string
#  city                 :string
#  address              :string
#  about                :string
#  confirmation_token   :string
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  parent_uuid          :string
#  right                :boolean          default(FALSE)
#  active               :boolean
#  admin                :boolean          default(FALSE)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class TempUser < ApplicationRecord
  #validations
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, :username, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX  }
  validates :username, length: { minimum: 4, maximum: 15 }
  validates :username, uniqueness: { case_sensitive: false }
  validate :username_existence
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  validates :parent_uuid, presence: true
  # validates_confirmation_of :password
  validate :parent_uuid_not_exist
  #associations
  
  has_many :invoices, dependent: :destroy
  #calllbacks
  before_create :generate_uuid
  before_create :generate_confirmation_instructions
  before_save   :downcase_email
  belongs_to    :sponsor, required: false, class_name: 'User', primary_key: 'uuid', foreign_key: 'parent_uuid'
  
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/img/anon_user.png'
  do_not_validate_attachment_file_type :avatar
  
  def username_existence
    user = User.find_by(username: self.username)
    errors.add(:username, "already taken") if user
  end

  def parent_uuid_not_exist
    parent = User.find_by(uuid: self.parent_uuid)
    errors.add(:sponsor, " No valid") if !self.parent_uuid.nil? && !parent
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
    self.active = false
  end

  def generate_confirmation_instructions
    self.confirmation_token = SecureRandom.uuid
    self.confirmation_sent_at = Time.now.utc
  end

  def downcase_email
    self.email = self.email.delete(' ').downcase
    self.username = self.username.delete(' ').downcase
  end

  def confirmation_token_valid?
    (self.confirmation_sent_at + 30.days) > Time.now.utc
  end

  def mark_as_confirmed!
    self.confirmation_token = nil
    self.confirmed_at = Time.now.utc
    save
  end
end
