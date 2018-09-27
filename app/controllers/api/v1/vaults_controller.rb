class Api::V1::VaultsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:update_unilevel_investments_rewards, :update_binary_rewards]
  
  # show current user balances in several currencies
  def show
    vault       = Vault.where(user_id:@current_user.id).select(:amount).first
    balance_btc = (vault.amount / Currency.btc_usd).round(8)
    balance_ltc = (vault.amount / Currency.ltc_usd).round(8)
    balance_usd = vault.amount.round(2)
    render json: {
      balance_btc: balance_btc,
      balance_ltc: balance_ltc,
      balance_usd: balance_usd
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