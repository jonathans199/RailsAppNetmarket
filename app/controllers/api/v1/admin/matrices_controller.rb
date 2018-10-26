class Api::V1::Admin::MatricesController < ApplicationController

  def update
    result = Matrix.where(reedemed:false).map{|x|
      result = "#{x.users.to_s},1"
      x.update(users:result) if x.users.split(",").count < 14 
    }.compact
    render json: result
  end

end
