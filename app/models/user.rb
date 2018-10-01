# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string
#  last_name           :string
#  username            :string
#  email               :string
#  password_digest     :string
#  phone               :string
#  document            :string
#  sponsor_uuid        :string
#  last_login          :datetime
#  uuid                :string
#  country             :string
#  city                :string
#  address             :string
#  about               :string
#  confirmed_at        :datetime
#  parent_uuid         :string
#  right               :boolean
#  active              :boolean
#  left_son            :boolean
#  openpro             :boolean          default(FALSE)
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  ancestry            :string
#  ancestry_depth      :integer          default(0)
#

class User < ApplicationRecord
  #associations
  # include ImageUploader[:image]
  has_secure_password
  has_ancestry :cache_depth => true
  has_many :invoices
  has_many :subscriptions
  has_many :plans, through: :invoices
  has_many :rewards, dependent: :destroy
  has_many :withdrawals, dependent: :destroy
  has_many :matrices, dependent: :destroy
  has_one :point
  has_one :vault
  belongs_to :sponsor, required: false, class_name: 'User', primary_key: 'uuid', foreign_key: 'sponsor_uuid'

  #validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX  }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  # validates_confirmation_of :password
  #calllbacks
  after_create :create_vault
  after_create :add_to_matrix
  before_save :downcase_username

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/img/anon_user.png'
  do_not_validate_attachment_file_type :avatar
    
  private 
    def add_to_matrix
      Compensation.matrix(self)
    end

    def create_vault
      Vault.create(user_id:self.id)
    end

    def create_point
      Point.create(user_id: self.id)
    end

    def downcase_username
      self.username = self.username.downcase
    end

    def rebuild_depth_cache!
      self.parent_uuid = self.parent.uuid if self.parent_uuid.nil? && !self.root?
      self.save
      self.class.rebuild_depth_cache!
    end
end