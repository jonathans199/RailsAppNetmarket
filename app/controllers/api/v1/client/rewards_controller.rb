class Api::V1::Client::RewardsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create_investment_rewards, :create_binary_rewards]
  
  # Get lates rewards for user
  def index
    render json: @current_user.rewards
      .where(created_at: Time.now.beginning_of_month..(Time.now))
      .select(:created_at,:value)
      .order(created_at: :asc)
      .map { |x|
        created_at = x.created_at.strftime("%b %d")
        {
          value: x.value,
          date: created_at
        }
      }
  end

  # create bynary reward and balance two sides
	def create_binary_rewards
    @users = User.all
    @users.each do |user|
      if UserCheck.user_has_two_directs_each_side?(user)
        point = user.point
        if point.left_points > point.right_points
          value = 0.1 * point.right_points
          point.left_points -= point.right_points
          point.right_points = 0
          Reward.create(value: value, reward_type_id: 13, reward_status_id: 11, currency_id: 11, user_id: user.id) if value > 0
        else
          value = 0.1 * point.left_points
          point.right_points -= point.left_points
          point.left_points = 0
          Reward.create(value: value, reward_type_id: 13, reward_status_id: 11, currency_id: 11, user_id: user.id) if value > 0
        end
        point.save
      end
    end
    render json: { message: 'Binary bonus rewards created' }, status: :ok
  end

  

  
end