class Api::V1::Client::StatsController < ApplicationController

  # show stats for binary rewards on current user
  def binary
    render json: @current_user.rewards.where(reward_type_id:13).order(created_at: :desc).map { |x| binary_filter(x) }
  end

  def residual_withdrawal
    render json: {
      rewards: @current_user.rewards.where(reward_type_id:14).order(created_at: :desc).map { |x| referral_filter(x) }.compact,
      counter: 0
    }
  end

  def residual_mining
    render json: {
      rewards: @current_user.rewards.where(reward_type_id:15).order(created_at: :desc).map { |x| referral_filter(x) }.compact,
      counter: 0
    }
  end
  # show rewards for every subscription on the user account
  def investments
    sentence = params[:id].to_i > 0 ? (@current_user.rewards.where(subscription_id:params[:id]).order(created_at: :desc).map { |x| investments_filter(x) }) : (@current_user.rewards.where(reward_type_id:11).order(created_at: :desc).map { |x| investments_filter(x) })
    render json: {
      user_investments: @current_user.subscriptions.where(plan_id: 1..6).map { |x| subs_filter(x) },
      rewards: sentence
   }
  end

  # list withdrawal requests
  def withdrew
    render json: @current_user.withdrawals.order(created_at: :desc).map { |x| withdrew_filter(x) }
  end

  # show purchases made by the user on the system
  def purchases
    render json: @current_user.invoices.where(invoice_status_id:12).order(created_at: :desc).map { |x| purchases_filter(x) }
  end

  # show unilevel bonus earned
  def referrals
    render json: {
      rewards: @current_user.rewards.where(reward_type_id:12).order(created_at: :desc).map { |x| referral_filter(x) }.compact,
      counter: User.all.where(sponsor_uuid: @current_user.uuid).count
    }
  end

  # show residual_bonus bonus earned
  def residual_bonus
    render json: {
      rewards: @current_user.rewards.where(reward_type_id:14).order(created_at: :desc).map { |x| referral_filter(x) }.compact
    }
  end

  private
    def referral_filter(object)
      object_tmp    = object
      invest_tmp    = object_tmp.attributes
      invest_tmp['plan_id']     = "#{object_tmp.subscription.plan.name} - $#{object_tmp.subscription.plan.price}"
      invest_tmp['currency_id']       = object_tmp.currency.name
      invest_tmp['reward_type_id']    = object_tmp.reward_type.name
      invest_tmp['reward_status_id']  = object_tmp.reward_status.name
      invest_tmp['user_refered']      = object_tmp.subscription.user.username
      invest_tmp['created_at'] = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      invest_tmp['updated_at'] = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      invest_tmp
    end

    def subs_filter(subs)
      subs_tmp    = subs
      remainig    = (300 - subs_tmp.rewards.count) if (1..6).include?(subs_tmp.plan_id)
      remainig    = (((subs_tmp.expiration) - (Time.now)) / 1.day ).round if subs_tmp.plan_id == 7
      subs        = subs.attributes
      subs['plan_id'] = subs_tmp.plan.name
      subs['plan_type'] = 'Bot subscription' if subs_tmp.plan.subscription
      subs['plan_type'] = 'Investment plan' if !subs_tmp.plan.subscription
      subs['invoice_id'] = subs_tmp.invoice.uuid
      subs['plan_value'] = subs_tmp.plan.price
      subs['subscription_status_id'] = subs_tmp.subscription_status.name
      subs['remaining_days']    = remainig
      subs['used_percent']      = (1..6).include?(subs_tmp.plan_id) ? (((((remainig * 100) / 300).round) - 100).abs) : (((((remainig * 100) / 180).round) - 100).abs)
      subs['is_bot'] = (1..6).include?(subs_tmp.plan_id) ? (false) : (true)
      subs['expiration'] = subs_tmp.expiration.strftime("%d/%m/%Y %I:%M%p")
      subs['created_at'] = subs_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      subs['updated_at'] = subs_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      subs
    end

    def binary_filter(object)
      object_tmp    = object
      binary        = object.attributes
      binary['currency_id']       = object_tmp.currency.name
      binary['reward_type_id']    = object_tmp.reward_type.name
      binary['reward_status_id']  = object_tmp.reward_status.name
      binary['created_at'] = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      binary['updated_at'] = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      binary
    end

    def investments_filter(object)
      object_tmp    = object
      invest_tmp    = object_tmp.attributes
      invest_tmp['plan_id']     = "#{object_tmp.subscription.plan.name} - $#{object_tmp.subscription.price}"
      invest_tmp['currency_id']     = object_tmp.currency.name
      invest_tmp['reward_type_id']  = object_tmp.reward_type.name
      invest_tmp['reward_status_id'] = object_tmp.reward_status.name
      invest_tmp['created_at'] = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      invest_tmp['updated_at'] = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      invest_tmp
    end

    def withdrew_filter(object)
      withdrew_tmp  = object
      withdrew      = withdrew_tmp.attributes
      withdrew['value']   = withdrew_tmp.value.to_s + " USD"
      withdrew['settle']  = withdrew_tmp.settle.to_s + " USD"
      withdrew['fees']    = withdrew_tmp.fees.to_s + " USD"
      withdrew['withdrawal_status_id'] = withdrew_tmp.withdrawal_status.name
      withdrew['currency_id'] = withdrew_tmp.currency.name
      withdrew['created_at']  = withdrew_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      withdrew['updated_at']  = withdrew_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      withdrew
    end

    def purchases_filter(object)
      object_tmp      = object
      purchase        = object.attributes
      purchase['currency_id']     = object_tmp.currency.name
      purchase['plan_id']         = "#{object_tmp.plan.name} - $#{(object_tmp.plan.price).round(2)}"
      purchase['invoice_status_id'] = object_tmp.invoice_status.name
      purchase['created_at'] = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      purchase['updated_at'] = object_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      purchase
    end
end
