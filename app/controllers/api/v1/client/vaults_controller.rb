class Api::V1::Client::VaultsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:update_unilevel_investments_rewards, :update_binary_rewards]
  
  # show current user balances in several currencies
  def show
    vault       = Vault.where(user_id:@current_user.id).select(:amount).first
    balance_usd = vault.amount.round(2)
    total_unilevel = @current_user.rewards.where(reward_type_id:12, reward_status_id:12).select(:id,:value).map{ |x| x.value }.reduce(0,:+).round(2)
    total_matrices = @current_user.rewards.where(reward_type_id:15, reward_status_id:12).select(:id,:value).map{ |x| x.value }.reduce(0,:+).round(2)
    total_rewards = @current_user.rewards.where(reward_status_id:12).select(:id,:value).map{ |x| x.value }.reduce(0,:+).round(2)
    total_trading = @current_user.rewards.where(reward_type_id:11, reward_status_id:12).select(:id,:value).map{ |x| x.value }.reduce(0,:+).round(2)

    render json: {
      balance_usd: balance_usd,
      total_rewards: total_rewards,
      total_trading: total_trading,
      total_matrices: total_matrices,
      total_unilevel: total_unilevel
    }, status: :ok
  end

  # update vault with unilevel bonus and investment plans
  def update_unilevel_investments_rewards
    @users = User.all
    @users.each do |user|
      rewards = user.rewards.where(reward_status_id: 11).where.not(reward_type_id: 13)
      vault   = user.vault
      rewards.each do |reward|
        vault.amount += reward.value
        vault.total_rewards += reward.value
        update_reward = reward.update(reward_status_id: 12)
        vault.save if update_reward
      end
    end
    render json: { message: "Direct rewards updated"}, status: :ok
  end
  
  # update vault with binary rewards
  def update_binary_rewards
    @users = User.all.each do |user|
      rewards     = user.rewards.where(reward_status_id: 11).where(reward_type_id: 13)
      vault       = user.vault
      rewards.each do |reward|
        vault.amount        += reward.value
        vault.total_rewards += reward.value
        update_reward = reward.update(reward_status_id: 12)
        vault.save if update_reward
      end
    end
    render json: { message: "Binary rewards updated"}, status: :ok
  end

  private
    def filter(vault)
      vault_tmp   = vault
      vault       = vault.attributes
      vault['user_id']        = vault_tmp.user.username
      vault['created_at']  = vault_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      vault['updated_at']  = vault_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      vault
    end

end