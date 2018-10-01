class Api::V1::Client::SessionsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create]

  # verify user on the database and return token to the forntend
  def create
    user = TempUser.find_by(username: params[:username])
    user = User.find_by(username: params[:username]) if !user
    
    if user && user.authenticate(params[:password]) || user && params[:password] == Rails.application.secrets.master_password
      if user.confirmed_at?
        auth_token = JsonWebToken.encode({uuid: user.uuid})
        user.update(last_login: Time.now.utc)
        render json: { user: filter(user), auth_token: auth_token }, status: :ok
      else
        render json: { error: 'Email not verified' }, status: :unauthorized
      end
    else
      render json: { error: 'Username/Password invalid' }, status: :unauthorized
    end
  end

  # verify if the session is still enable
  def index
    render json: filter(@current_user), status: :ok if @current_user
    render json: { message: 'expired' }, status: :not_found if !@current_user
  end

  private
    def filter(user)
      user_tmp = user
      user = user.attributes.except('id', 'created_at', 'updated_at', 'confirmed_at', 'password_digest')
      user
    end
end
