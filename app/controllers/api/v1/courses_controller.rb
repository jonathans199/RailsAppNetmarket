class Api::V1::CoursesController < ApplicationController

  def index
    render json: Course.all.order(id: :desc).map { |x| filter(x) }
  end

  def show
    render json: filter(Course.find(params[:id]))
  end

  private
    def filter(object)
      port        = request.port == 443 ? (80) : (request.port)
      base_url    = "http://#{request.host}:#{port}"
      object_tmp  = object
      object      = object.attributes
      object['title'] = object_tmp.title.capitalize
      object['description'] = object_tmp.description.capitalize
      object['avatar'] = {
        medium: base_url + object_tmp.avatar.url(:medium),
        thumb: base_url + object_tmp.avatar.url(:medium),
        original: base_url + object_tmp.avatar.url(:original)
      }
      object['category'] = object_tmp.category.name
      object['units'] = object_tmp.units.count
      object
    end
end
