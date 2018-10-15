class Api::V1::Client::UsersController < ApplicationController
  skip_before_action :authenticate_request!, except: [:show, :update, :activation_request, :biggest_plan]
  include ActionView::Helpers::DateHelper

  # show last users on the dashboard
  def index
    from_time = Time.now
    render json: User.all.select(:username,:created_at).order(id: :desc).limit(6).map { |x|
        time_ago = distance_of_time_in_words(x.created_at.to_i, from_time + 1.minutes)
        {
          username: x.username,
          created_at: time_ago
        }
      }
  end

  # create new user 
  def create
    @user             = TempUser.new(user_params)
    referer           = User.find_by(username: params[:parent_uuid])
    referer           = User.find_by(uuid: params[:parent_uuid]) if !referer
    @user.parent_uuid = referer.uuid if referer

    # render json:  @user
    password  = params[:password]
    if @user.save
      EmailNotification.send_confirmation_email(password,@user)
      render json: filter(@user), status: :ok
    else
      render json: @user.errors.map { |x, mess| "#{x} #{mess}".capitalize }, status: :unprocessable_entity
    end
  end

  # show user attributes
  def show
    render json: filter(@current_user), status: :ok
  end

  # update user attributes
  def update
    if @current_user.update(update_params)
      render json: filter(@current_user), status: :ok
    else
      render json: { message: @current_user.errors.map { |x, mess| "#{x} #{mess}".capitalize } }, status: :unprocessable_entity
    end
  end

  # confirm the token that the user got in his email
  def confirm
    token = params[:confirmation_token].to_s
    user = TempUser.find_by(confirmation_token: token)
    if user.present? && user.confirmation_token_valid?
      user.mark_as_confirmed!
      auth_token = JsonWebToken.encode({uuid: user.uuid})
      # render json: { auth_token: auth_token }, status: :ok
      redirect_to Rails.application.secrets.confirm_redirect
    else
      render json: { status: 'Invalid token' }, status: :not_found
    end
  end

  # recover authentication token for user
  def resend_token
    @user = TempUser.find_by(username: params[:username])
    if @user.present?
      @user.generate_confirmation_instructions
      @user.save
      send_confirmation_email
      render json: { status: 'Confirmation token was resent to your email' }, status: :ok
    else
      render json: { status: 'Invalid username' }, status: :not_found
    end
  end

  # send a new password to user email
  def pass_recovery
    @user = TempUser.find_by(username: params[:username])
    @user = User.find_by(username: params[:username]) if !@user
    if @user.present?
      @new_password = SecureRandom.hex(5)
      @user.update(username: params[:username], password: @new_password, password_confirmation: @new_password)
      EmailNotification.send_recovery_email(@user,@new_password)
      render json: { status: 'New password has been sent to your email' }, status: :ok
    else
      render json: { status: 'Invalid username' }, status: :not_found
    end
  end

  # get the user biggest active plan
  def biggest_plan
    is_user = @current_user.respond_to? :subscriptions 
    subs = is_user ? (@current_user.subscriptions.map{ |x| x.price if x.subscription_status_id == 11 }.compact.max) : ({ m: 'Temp user' })
    render json: subs
  end

  private
    def user_params
      params.permit(
        :name,
        :last_name,
        :email,
        :username,
        :password,
        :password_confirmation,
        :phone,
        :document,
        :country,
        :city,
        :address,
        :about,
        :parent_uuid,
        :right,
        :avatar
      )
    end

    def update_params
      params.permit(:name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :phone,
        :ID_card,
        :avatar,
        :address,
        :city,
        :country,
        :about,
        :right,
        :document)
    end

    def filter(object)
      port        = request.port == 443 ? (80) : (request.port)
      base_url    = "http://#{request.host}:#{port}"
      object_tmp  = object
      object      = object.attributes.except('id','created_at', 'updated_at', 'password_digest', 'confirmation_token', 'active')
      object['avatar'] = {
        medium: base_url + object_tmp.avatar.url(:medium),
        thumb: base_url + object_tmp.avatar.url(:medium),
        original: base_url + object_tmp.avatar.url(:original)
      }
      object['created_at']  = object_tmp.created_at.strftime("%d/%m/%Y %I:%M%p")
      object['active']      = object_tmp.active ? 'Active' : 'Inactive'
      object
    end
end