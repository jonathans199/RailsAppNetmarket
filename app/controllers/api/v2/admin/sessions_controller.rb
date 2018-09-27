class Api::V2::Admin::SessionsController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create]

  def create
    user = TempUser.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
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
  
  private
    def filter(user)
      user_tmp = user
      user = user.attributes.except('id', 'created_at', 'updated_at', 'confirmed_at', 'password_digest')
      user
    end
end
