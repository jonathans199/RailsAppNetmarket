class Api::V2::Admin::CoursesController < ApplicationController

  def index
    render json: Course.all.order(created_at: :desc).map { |x| filter(x) }
  end
  
  def create
    @course = Course.new(course_params)
    if @course.save
      render json: filter(@course), status: :ok
    else
      render json: { message: @course.errors.map { |x, mess| "#{x} #{mess}".capitalize } }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: Course.find(params[:course_id]).destroy
  end

  def show
    render json: filter(Course.find(params[:id]))
  end

  private
    def course_params
      params.permit(
        :admin_id,
        :title,
        :category_id,
        :description,
        :language,
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
      object['category']    = object_tmp.category.name
      object['units']       = object_tmp.units.count
      object['created_at']  = object_tmp.created_at.strftime("%d %b, %Y %I:%M%p")
      object['updated_at']  = object_tmp.created_at.strftime("%d %b, %Y %I:%M%p")
      object
    end
end
