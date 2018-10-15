class Api::V1::Admin::PlansController < ApplicationController
  before_action :admin_user
  
  def index
    plans = Plan.all
    render json: plans, status: 200
  end

end
