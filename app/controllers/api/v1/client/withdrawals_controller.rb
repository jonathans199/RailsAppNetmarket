class Api::V1::Client::WithdrawalsController < ApplicationController
  # check if the current day is available for withdrawal requests
  def set_view
    base_time = Time.zone.now
    date = (6..(15)).to_a.include?(base_time.strftime("%H").to_i) ? (base_time.strftime("%A")) : ('Out of range')
    user_withdrawals = @current_user.withdrawals.where(withdrawal_status_id: 11)
    user_withdrawals.count > 0 ? (pending = true) : (pending = false)
    render json: { 
      time: base_time,
      date: date, 
      pending: pending,
      withdrawals_enabled: @current_user.withdrawals_enabled }, status: :ok
  end

  # user can request a withdrawal to crypto wallet or sell value to another user
  def create
    errors = []
    if params[:currency_id].to_i == 14
      user_to_gift = User.find_by(username:params[:coupon_username])
      errors.push("Username not found") if !user_to_gift
    else
      errors.push("Wallet can't be blank")            if params[:wallet].blank?
    end
    errors.push("Value can't be negative or zero") if params[:value].to_f <= 0
    errors.push("Minimum withdraw amount is 100")  if params[:value].to_f < 100
    balance_error = check_balance(@current_user, params[:value])
    errors.push(balance_error) unless balance_error.blank?
    
    if errors.count > 0
      render json: { errors: errors }, status: :unprocessable_entity
    else
      currency    = params[:currency_id].to_i == 14 ? (11) : (params[:currency_id].to_i)
      txid        = user_to_gift.username if params[:currency_id].to_i == 14 && user_to_gift
      status      = params[:currency_id].to_i == 14 ? (12) : (11)
      withdrawal  = Withdrawal.new(
        user_id: @current_user.id,
        withdrawal_type_id: params[:withdrawal_type_id],
        withdrawal_status_id: status,
        value: params[:value].to_f,
        fees: calculate_fees(params[:value]),
        currency_id: currency,
        settle: calculate_settle(params[:value]),
        wallet: params[:wallet],
        comments: params[:comments],
        txid: txid
      )
      if withdrawal.save
        user_to_gift.rewards.create(value:calculate_settle(params[:value]), reward_type_id:14,reward_status_id:11,currency_id:11) if params[:currency_id].to_i == 14 && user_to_gift
        vault         = @current_user.vault
        vault.amount -= params[:value].to_f
        vault.total_withdrawals += params[:value].to_f
        vault.save
        render json: withdrawal, status: :ok
      end
    end
  end

  private
    def check_balance(user, value)
      amount = user.vault.amount
      error = ""
      error = "Value can't be greater than your vault amount" if (amount.round(2) - value.to_f.round(2)) < 0
      error
    end

    def calculate_fees(value)
      (value.to_f.round(2) * 0.05).round(2)
    end

    def calculate_settle(value)
      (value.to_f.round(2) * 0.95).round(2)
    end
end
