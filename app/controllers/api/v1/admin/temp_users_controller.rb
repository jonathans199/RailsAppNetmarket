class Api::V1::Admin::TempUsersController < ApplicationController
  before_action :admin_user

  # list all  users on the system
  def index
    render json: TempUser.all.map { |x| filter(x) }
  end

  # show user details
  def show
    render json: filter(TempUser.find(params[:id]))
  end

  # update user data
  def update
    user  =   TempUser.find(params[:id])
    col   =   params[:col]
    xyz   =   params[:val]
    response = user.update("#{col}": xyz)
    render json: response, status: 200
  end
  
  private
    def filter(user)
      user_tmp = user
      user = user.attributes.except('created_at', 'updated_at', 'password_digest', 'confirmation_token', 'active')
      user['created_at'] = user_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      user['updated_at'] = user_tmp.updated_at.strftime("%d/%m/%Y %I:%M%p")
      user['parent']  = "Not active yet"
      user['sponsor'] = user_tmp.sponsor ? (user_tmp.sponsor.username) : (nil)
      user['active']  = user_tmp.active ? ('Active'): ('Inactive')
      user
    end
end
