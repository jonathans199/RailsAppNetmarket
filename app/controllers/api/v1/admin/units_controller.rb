class Api::V1::Admin::UnitsController < ApplicationController

  # list all units of a course
  def index
    render json: Unit.where(course_id:params[:course_id]).order(created_at: :desc).map { |x| filter(x)  }
  end

  # create unit for specific course
  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      render json: filter(@unit), status: :ok
    else
      render json: { message: @unit.errors.map { |x, mess| "#{x} #{mess}".capitalize } }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: Unit.find(params[:unit_id]).destroy
  end

  private
    def unit_params
      params.permit(
        :course_id,
        :title,
        :duration,
        :description,
        :embed_code,
        :avatar)
    end

    def filter(object)
      port        = request.port == 443 ? (80) : (request.port)
      base_url    = "http://#{request.host}:#{port}"
      object_tmp  = object
      object      = object.attributes
      object['avatar'] = {
        medium: base_url + object_tmp.avatar.url(:medium),
        thumb: base_url + object_tmp.avatar.url(:medium),
        original: base_url + object_tmp.avatar.url(:original)
      }

      object['created_at']  = object_tmp.created_at.strftime("%d %b, %Y %I:%M%p")
      object['updated_at']  = object_tmp.created_at.strftime("%d %b, %Y %I:%M%p")
      object
    end
end
