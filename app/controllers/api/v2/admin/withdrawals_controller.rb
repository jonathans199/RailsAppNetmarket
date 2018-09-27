class Api::V2::Admin::WithdrawalsController < ApplicationController
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
    settle = (settle / Currency.btc_usd).to_f.round(8) if params[:currency] == "BTC"
    settle = (settle / (Currency.btc_usd * Currency.ltc_btc)).to_f.round(8) if params[:currency] == "LTC"
    render json: settle, status: :ok
  end

  # aprove withdrawals
  def update
    return render json: { message: 'TXID required' }, status: :unprocessable_entity if params[:txid].nil? && Withdrawal.find_by(uuid: params[:uuid]).withdrawal_type_id == 11
    @withdrawal = Withdrawal.find_by(uuid: params[:uuid])
    return render json: { error: 'Withdrawal not exist' }, status: :bad_request if !@withdrawal
    paid = @withdrawal.update(:withdrawal_status_id => 12, :txid => params[:txid])
    settle_crypto = params[:settle_crypto]
    send_info(settle_crypto) if paid
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
      withdrawal['currency'] = withdrawal_tmp.currency.name
      withdrawal['withdrawal_status_id'] = withdrawal_tmp.withdrawal_status.name
      withdrawal['withdrawal_type_id'] = withdrawal_tmp.withdrawal_type.name
      withdrawal['currency_id'] = withdrawal_tmp.currency.name
      withdrawal['created_at'] = withdrawal_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      withdrawal
    end

    def send_info(settle_crypto)
      # mg_client = Mailgun::Client.new Rails.application.secrets.mail_gun_api_key
      # if @withdrawal.withdrawal_type_id == 11
      #   message_params =  { from: 'no-reply@mg..com',
      #                       to:   @withdrawal.user.email,
      #                       subject: 'Waves trading - Withdrawal updated',
      #                       html:    "
      #                       <div style='font-family: sans-serif; text-align: center; width: 500px; height: auto; margin-right: auto; margin-left: auto; padding: 10px 20px 40px 20px; background-color: midnightblue;'>
      #                       <h1 style='color: #eabe3f; font-size: 300%; text-align: left;'>Waves trading</h1>
      #                       <br/>
      #                       <h2 style='color: white; font-size: 200%;'>PAYMENT MADE</h2>
      #                       <h3 style='font-size: 150%; color: #eabe3f; display: inline; margin-right: 20px;'>USERNAME</h3>
      #                       <p style='font-size: 130%; color: white; display: inline;'>#{@withdrawal.user.username.upcase}</p>
      #                       <br/>
      #                       <div style='border: 5px solid #eabe3f; width: 420px; height: auto; margin-right: auto; margin-left: auto; margin-top: 20px; text-align: left; padding: 20px 20px;'>
      #                       <h3 style='font-size: 130%; color: #eabe3f; display: inline; margin-right: 20px;'>UUID</h3>
      #                       <p style='font-size: 110%; color: white; display: inline;'>#{@withdrawal.uuid}</p>
      #                       <br/>
      #                       <h3 style='font-size: 130%; color: #eabe3f; display: inline; margin-right: 20px;'>TRANSACTION HASH</h3>
      #                       <p style='font-size: 110%; color: white; display: inline;'>#{@withdrawal.txid}</p>
      #                       <br/>
      #                       <h3 style='font-size: 130%; color: #eabe3f; display: inline; margin-right: 20px;'>SETTLE</h3>
      #                       <p style='font-size: 110%; color: white; display: inline;'>#{@withdrawal.settle} USD</p>
      #                       <br/>
      #                       <h3 style='font-size: 130%; color: #eabe3f; display: inline; margin-right: 20px;'>SETTLE IN CRYPTOCURRENCY</h3>
      #                       <p style='font-size: 110%; color: white; display: inline;'>#{settle_crypto} #{@withdrawal.currency.name}</p>
      #                       <br/>
      #                       </div>
      #                       <div style='border: 5px solid #eabe3f; width: 420px; height: auto; margin-right: auto; margin-left: auto; margin-top: 0px; text-align: left; padding: 20px 20px; border-top: 0px solid #eabe3f;'>
      #                       <h3 style='font-size: 150%; color: #eabe3f; display: inline; margin-right: 20px;'>WALLET</h3>
      #                       <p style='font-size: 130%; color: white; display: inline;'>#{@withdrawal.wallet}</p>
      #                       <br/>
      #                       </div>
      #                       </div>"
      #                     }
      # end
      # mg_client.send_message 'mg..com', message_params
    end
end