class Api::V1::Client::PointsController < ApplicationController

  # show current user poins on two sides
  def user
    pointsArray = []
    params[:arrays].each do |username|
      user = User.find_by(username: username)
      if user
        points = user.point
        pointsArray.push(["LP: " + points.left_points.to_s, "RP: " + points.right_points.to_s])
      else
        pointsArray.push(["LP: 0", "RP: 0"])
      end
    end
    render json: pointsArray, status: :ok
  end

  # show user points earned
  def show
    point = @current_user.point
    render json: point, status: :ok
  end

  # count total points on the user
  def total
    user  = User.find_by(uuid: params[:uuid])
    point = Point.where(user_id:user.id).select(:left_points,:right_points).first
    render json: { LP: point.left_points, RP: point.right_points }, status: :ok
  end
  
  # count user total rewards
  def total_rewards
    total_paid_rewards  = @current_user.rewards.where(reward_status_id: 12)
    total_investment    = total_paid_rewards.where(reward_type_id: 11).inject(0){|sum, r| sum + r.value }
    total_binary        = total_paid_rewards.where(reward_type_id: 13).inject(0){|sum, r| sum + r.value }
    total_ten_first     = total_paid_rewards.where(reward_type_id: 14).inject(0){|sum, r| sum + r.value }
    render json: {investment: total_investment, binary: total_binary, ten_first: total_ten_first}, status: :ok
  end
end
