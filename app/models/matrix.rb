class Matrix < ApplicationRecord
	belongs_to :user
	belongs_to :plan

  before_create :generate_uuid
	validates :plan_id, uniqueness: { scope: [:user_id, :reedemed] }, :on => :create
	validate :users_on_matrix, :on => :update

	private
		def users_on_matrix
			current_count   = self.users.split(",").count - 1
			user_matrix_no  = self.user.matrices.where(plan_id: self.plan_id).select(:id).count
			current_directs	= directs_on_matrix(self)

			base_allowed    = 2 if user_matrix_no == 1
			base_allowed 		= 3 if user_matrix_no == 2
			base_allowed 		= 3 if user_matrix_no == 3
			base_allowed 		= 3 if user_matrix_no == 4
			base_allowed 		= 3 if user_matrix_no == 5
			base_allowed 		= 3 if user_matrix_no == 6
			# until here its 3 users per matrix
			base_allowed 		= 4 if user_matrix_no == 7
			base_allowed 		= 4 if user_matrix_no == 8
			base_allowed 		= 4 if user_matrix_no == 9
			base_allowed 		= 4 if user_matrix_no == 10
			base_allowed 		= 4 if user_matrix_no == 11

			directs_allowed = base_allowed - current_directs
			max 						= 15           - directs_allowed
			return errors.add(:matrix, "No free spaces") if max == current_count
		end

		def directs_on_matrix(matrix)
			direct_total = 	matrix.users.split(",").map{ |y| y if y != '1' && User.find(y).parent_uuid === matrix.user.uuid }.compact
			return direct_total.count
		end
		
		def generate_uuid
			self.uuid = SecureRandom.uuid
		end

end
