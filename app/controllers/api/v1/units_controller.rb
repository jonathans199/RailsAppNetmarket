class Api::V1::UnitsController < ApplicationController

  # list specific unit of a course
  def show
    render json: filter(Unit.find(params[:id]))
  end

  # list all units of a course
  def index
    render json: Unit.where(course_id:params[:course_id]).order(created_at: :desc).map { |x| filter(x)  }
  end

  private
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
