class Api::V1::RewardsController < ApplicationController
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

  # create reward for every active subscription on the system based on the percent posted by the admin
  def create_investment_rewards
    subscriptions = Subscription.where(subscription_status_id: 11)
    subscriptions = subscriptions.map{ |x|
      profit     = (x.price * 0.03).round(2) if x.price >= 50 && x.price < 10050
      profit     = (x.price * 0.04).round(2) if x.price >= 10050 && x.price < 20050
      profit     = (x.price * 0.05).round(2) if x.price >= 20050
      allowed    = true
      allowed    = x.rewards.count == 0 ? (false) : (true)
      allowed    = !allowed ? (x.created_at.beginning_of_day + 2.days < Time.zone.now.beginning_of_day) : (true)

      reward = x.rewards.create(
        value: profit,
        reward_type_id: 11,
        reward_status_id: 11,
        currency_id: 11,
        user_id:x.user_id) if allowed
      create_residual_mining(reward) if reward
    }
    render json: subscriptions
  end

  private
    def create_residual_mining(reward)
      base_price  = (reward.value) * 0.1
      value       = ((base_price * 30) / 100).round(2)
      first_user  = User.find_by(uuid: reward.user.parent_uuid)
      first       = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: first_user.id, subscription_id: reward.subscription.id) if first_user
      if first_user
        value         = ((base_price * 20) / 100).round(2)
        second_user   = User.find_by(uuid: first_user.parent_uuid)
        second        = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: second_user.id, subscription_id: reward.subscription.id) if second_user
        if second_user
          value         = ((base_price * 20) / 100).round(2)
          third_user    = User.find_by(uuid: second_user.parent_uuid)
          third         = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: third_user.id, subscription_id: reward.subscription.id) if third_user
          if third_user
            value         = ((base_price * 10) / 100).round(2)
            fourth_user   = User.find_by(uuid: third_user.parent_uuid)
            third         = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: fourth_user.id, subscription_id: reward.subscription.id) if fourth_user
            if fourth_user
              value         = ((base_price * 10) / 100).round(2)
              fifth_user    = User.find_by(uuid: fourth_user.parent_uuid)
              third         = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: fifth_user.id, subscription_id: reward.subscription.id) if fifth_user
              if fifth_user
                value         = ((base_price * 10) / 100).round(2)
                sixth_user    = User.find_by(uuid: fifth_user.parent_uuid)
                third         = Reward.create(value: value, reward_type_id: 14, reward_status_id: 11, currency_id: 11, user_id: sixth_user.id, subscription_id: reward.subscription.id) if sixth_user
              end
            end
          end
        end
      end
      return true
    end
end