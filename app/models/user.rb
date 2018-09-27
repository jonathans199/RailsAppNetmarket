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
  has_many :coupons
  has_one :point
  has_one :vault
  has_one :server_config
  has_many :botpro_requests
  belongs_to :sponsor, required: false, class_name: 'User', primary_key: 'uuid', foreign_key: 'sponsor_uuid'

  #validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, :username, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX  }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
  # validates_confirmation_of :password
  #calllbacks
  after_create :define_roots, if: :roots_are_not_defined?
  after_create :assign_parent, if: :roots_are_defined?
  after_create :rebuild_depth_cache!
  after_create :create_vault
  after_create :create_point
  before_save :downcase_username

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/img/anon_user.png'
  do_not_validate_attachment_file_type :avatar
    
  private 

    def create_vault
      Vault.create(user_id:self.id)
    end

    def create_point
      Point.create(user_id: self.id)
    end

    def downcase_username
      self.username = self.username.downcase
    end

    def roots_are_not_defined?
      if self.class.roots.exists?
        return true if self.class.roots[0].children.count < 2
      end
    end

    def roots_are_defined?
      if self.class.roots.exists?
        return true if self.class.roots[0].children.count == 2
      end
    end

    def define_roots
      self.ancestry = self.class.roots[0].id.to_s
    end

    def assign_parent
      self.parent_uuid = self.class.roots[0].uuid if self.parent_uuid.nil?
      parent = self.class.find_by(uuid: self.parent_uuid)
      if parent.right
        self.left_son = false
        if parent.children.count == 2 || parent.children.where(left_son: false).count == 1
          self.ancestry = find_last_user(parent.children.where(left_son: false).first, false)
        else
          self.ancestry = parent.ancestry + '/' + parent.id.to_s
        end
      else
        self.left_son = true
        if parent.children.count == 2 || parent.children.where(left_son: true).count == 1
          self.ancestry = find_last_user(parent.children.where(left_son: true).first, true)
        else
          self.ancestry = parent.ancestry + '/' + parent.id.to_s
        end
      end
    end
  
    def find_last_user(user, left)
      result = user.children.where(left_son: left) if user
      return user.ancestry + '/' + user.id.to_s if result.count == 0
      find_last_user(result.first, left)
    end

    # def assign_parent
    #   self.parent_uuid = self.class.roots[0].uuid if self.parent_uuid.nil?
    #   parent = self.class.find_by(uuid: self.parent_uuid)
    #   right = parent.right
    #   if right
    #     if parent.children.where(left_son: false).empty?
    #       self.ancestry = parent.ancestry + '/' + parent.id.to_s
    #       self.left_son = false
    #     else
    #       parent = parent.children.where(left_son: false)[0]
    #       sw = true
    #       begin
    #         if parent.children.where(left_son: false).empty?
    #           self.ancestry = parent.ancestry + '/' + parent.id.to_s
    #           self.left_son = false
    #           sw = false
    #         else
    #           parent = parent.children.where(left_son: false)[0]
    #         end
    #       end until sw == false
    #     end
    #   else
    #     if parent.children.where(left_son: true).empty?
    #       self.ancestry = parent.ancestry + '/' + parent.id.to_s
    #       self.left_son = true
    #     else
    #       parent = parent.children.where(left_son: true)[0]
    #       sw = true
    #       begin
    #         if parent.children.where(left_son: true).empty?
    #           self.ancestry = parent.ancestry + '/' + parent.id.to_s
    #           self.left_son = true
    #           sw = false
    #         else
    #           parent = parent.children.where(left_son: true)[0]
    #         end
    #       end until sw == false
    #     end
    #   end
    # end

    def rebuild_depth_cache!
      self.parent_uuid = self.parent.uuid if self.parent_uuid.nil? && !self.root?
      self.save
      self.class.rebuild_depth_cache!
    end
end