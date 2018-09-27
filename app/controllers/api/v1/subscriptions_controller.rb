class Api::V1::SubscriptionsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:verify_bot_subscriptions, :verify_inversion_subscriptions]

  # list all the subscriptions for the user
  def index
    @subscriptions = @current_user.subscriptions.order(created_at: :desc).map { |subs| filter(subs) }
    render json: @subscriptions, status: :ok
  end

  # show current subscription status
  def show
    render json: filter(@current_user.subscriptions.find(params[:id])), status: :ok
  end

  # used to mark users on the tree with a color representation
  def greatest
    plansArray = []
    params[:arrays].each do |username|
      user = User.find_by(username: username)
      if user
        subscription = user.subscriptions.where.not(plan_id: 7).where(subscription_status_id: 11).order(plan_id: :desc).first
        if subscription
          plansArray.push(filter_greatest(subscription))
        else
          plansArray.push({})
        end
      else
        plansArray.push({})
      end
    end
    render json: plansArray, status: :ok
  end

  private
    def filter(subs)
      subs_tmp    = subs
      max_pay     = subs.price * 2
      paid        = subs_tmp.rewards.where(reward_type_id: 11).map { |x| x.value }.reduce(0, :+)
      remainig    = max_pay - paid
      subs        = subs.attributes
      subs['plan_name'] = subs_tmp.plan.name
      subs['membership_plan'] = subs_tmp.plan.subscription && subs_tmp.plan.id == 1 ? (true) : (false)
      subs['invoice_id'] = subs_tmp.invoice.uuid
      subs['plan_value'] = subs_tmp.price
      subs['subscription_status_id'] = subs_tmp.subscription_status.name
      subs['paid']       = paid
      subs['remainig']   = remainig
      subs['used_percent']   = (100 * paid) / max_pay
      subs['used_percent']   = 100 if subs_tmp.subscription_status_id == 12
      subs['expiration'] = subs_tmp.expiration.strftime("%d/%m/%Y %I:%M%p")
      subs['created_at'] = subs_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      subs['updated_at'] = subs_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      subs
    end

    def filter_greatest(subs)
      subs_tmp    = subs
      subs        = subs.attributes
      subs['plan_name'] = subs_tmp.plan.name
      subs['plan_value'] = subs_tmp.price
      subs
    end
end