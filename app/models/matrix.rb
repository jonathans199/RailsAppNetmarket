class Matrix < ApplicationRecord
	belongs_to :user
	belongs_to :plan

  before_create :generate_uuid
	validates :plan_id, uniqueness: { scope: [:user_id, :reedemed] }, :on => :create

  private
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end
end
