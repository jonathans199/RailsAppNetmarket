class Api::V1::Admin::UsersController < ApplicationController
  before_action :admin_user

  # list all  users on the system
  def index
    render json: User.all.order(created_at: :desc).map { |x| filter(x) }
  end

  # show user details
  def show
    render json: filter(User.find(params[:id]))
  end

  # update user data
  def update
    user  =   User.find(params[:id])
    col   =   params[:col]
    xyz   =   params[:val]
    xyz   =  false if params[:val] == "false"
    xyz   =  true if params[:val] == "true"
    response = user.update("#{col}": xyz)
    render json: response, status: 200
  end

  private
    def filter(user)
      user_tmp = user
      user = user.attributes.except('created_at', 'updated_at', 'password_digest', 'confirmation_token', 'active')
      user['created_at'] = user_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      user['updated_at'] = user_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      user['parent']  = user_tmp.parent
      user['sponsor'] = user_tmp.sponsor ? (user_tmp.sponsor.username) : (nil)
      user['active']  = user_tmp.active
      user
    end
end
