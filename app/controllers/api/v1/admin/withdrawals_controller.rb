class Api::V1::Admin::WithdrawalsController < ApplicationController
  before_action :admin_user

  def pending
    @withdrawals = Withdrawal.where(withdrawal_status_id: 11).order(id: :desc).map { |withdrawal| filter(withdrawal) }
    render json: @withdrawals
  end

  def approved
    @withdrawals = Withdrawal.where(withdrawal_status_id: 12..13).order(id: :desc).map { |withdrawal| filter(withdrawal) }
    render json: @withdrawals
  end

  def convert
    settle = params[:settle].to_f
    settle = (settle / BittrexInt.btc_usd).to_f.round(8) if params[:currency] == "BTC"
    settle = (settle / (BittrexInt.btc_usd * BittrexInt.ltc_btc)).to_f.round(8) if params[:currency] == "LTC"
    render json: settle, status: :ok
  end

  # aprove withdrawals
  def update
    return render json: { message: 'TXID required' }, status: :unprocessable_entity if params[:txid].nil? && Withdrawal.find_by(uuid: params[:uuid]).withdrawal_type_id == 11
    @withdrawal = Withdrawal.find_by(uuid: params[:uuid])
    return render json: { error: 'Withdrawal not exist' }, status: :bad_request if !@withdrawal
    paid = @withdrawal.update(:withdrawal_status_id => 12, :txid => params[:txid])
    settle_crypto = params[:settle_crypto]
    render json: @withdrawal, status: :ok
  end

  # destroy withdrawal and return balance to the user
  def destroy
    withdrawal = Withdrawal.find_by(uuid:  params[:id])
    if withdrawal.withdrawal_status_id == 11
      withdrawal.update(withdrawal_status_id: 13)
      vault   = withdrawal.user.vault
      vault.update(amount:vault.amount + withdrawal.value, total_withdrawals: vault.total_withdrawals - withdrawal.value)
      render json: { message: 'Updated' }
    else
      render json: { message: 'Not cancelled' }
    end
  end

  private
    def filter(withdrawal)
      withdrawal_tmp = withdrawal
      withdrawal = withdrawal.attributes
      withdrawal['user_id'] = withdrawal_tmp.user.username
      withdrawal['currency'] = withdrawal_tmp.currency ? (withdrawal_tmp.currency.name) : ('')
      withdrawal['withdrawal_status_id'] = withdrawal_tmp.withdrawal_status.name
      withdrawal['withdrawal_type_id'] = withdrawal_tmp.withdrawal_type.name
      withdrawal['currency_id'] = withdrawal_tmp.currency ? (withdrawal_tmp.currency.name) : ('')
      withdrawal['created_at'] = withdrawal_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      withdrawal
    end
end