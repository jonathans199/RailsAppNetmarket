class Api::V1::Client::TreesController < ApplicationController

  def index
    matrices = @current_user.matrices.map{ |x| filter(x) }
    render json: matrices, status: 200
  end

  # show current user tree
  def show
    if @current_user.matrices.count > 0
      matrix = filter(@current_user.matrices.last)
      render json: matrix, status: 200
    else
      render json: { m: "No active matrices" }, status: 400
    end

  end

  private

    def filter(matrix)
      matrix_tmp = matrix
      matrix = matrix.attributes
      matrix['users'] = fetch_user(matrix_tmp.users)
      matrix['plan'] = matrix_tmp.plan.name
      matrix['plan_price'] = matrix_tmp.plan.price
      matrix
    end

    def fetch_user(array)
      array = "#{@current_user.id},#{array}"
      array = array.split(",").map{ |x|
        User.where(id:x).select(:uuid,:username,:created_at).last
      }.compact
      # return array.count
    end

    def tree_array(user)
      array = []
      array.push(user["username"], user["uuid"])
      if user["children"][0].nil?
        array.push("No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User")
      else
        if user["children"][0]["left_son"]
          if user["children"][1].nil?
            array.push(user["children"][0]["username"], user["children"][0]["uuid"], "No User", "No User")
            if user["children"][0]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User")
            else
              if user["children"][0]["children"][0]["left_son"]
                if user["children"][0]["children"][1].nil?
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User", "No User", "No User", "No User", "No User")
                else
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"], "No User", "No User", "No User", "No User")
                end
              else
                if user["children"][0]["children"][1].nil?
                  array.push("No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User", "No User", "No User")
                else
                  array.push(user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"], user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User", "No User", "No User")
                end
              end
            end
          else
            array.push(user["children"][0]["username"], user["children"][0]["uuid"], user["children"][1]["username"], user["children"][1]["uuid"])
            if user["children"][0]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User")
            else
              if user["children"][0]["children"][0]["left_son"]
                if user["children"][0]["children"][1].nil?
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User")
                else
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"])
                end
              else
                if user["children"][0]["children"][1].nil?
                  array.push("No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                else
                  array.push(user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"], user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                end
              end
            end
            if user["children"][1]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User")
            else
              if user["children"][1]["children"][0]["left_son"]
                if user["children"][1]["children"][1].nil?
                  array.push(user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"], "No User", "No User")
                else
                  array.push(user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"], user["children"][1]["children"][1]["username"], user["children"][1]["children"][1]["uuid"])
                end
              else
                if user["children"][1]["children"][1].nil?
                  array.push("No User", "No User", user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"])
                else
                  array.push(user["children"][1]["children"][1]["username"], user["children"][1]["children"][1]["uuid"], user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"])
                end
              end
            end
          end
        else
          if user["children"][1].nil?
            array.push("No User", "No User", user["children"][0]["username"], user["children"][0]["uuid"])
            if user["children"][0]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User", "No User", "No User", "No User", "No User")
            else
              if user["children"][0]["children"][0]["left_son"]
                if user["children"][0]["children"][1].nil?
                  array.push("No User", "No User", "No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User")
                else
                  array.push("No User", "No User", "No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"])
                end
              else
                if user["children"][0]["children"][1].nil?
                  array.push("No User", "No User", "No User", "No User", "No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                else
                  array.push("No User", "No User", "No User", "No User", user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"], user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                end
              end
            end
          else
            array.push(user["children"][1]["username"], user["children"][1]["uuid"], user["children"][0]["username"], user["children"][0]["uuid"])
            if user["children"][1]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User")
            else
              if user["children"][1]["children"][0]["left_son"]
                if user["children"][1]["children"][1].nil?
                  array.push(user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"], "No User", "No User")
                else
                  array.push(user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"], user["children"][1]["children"][1]["username"], user["children"][1]["children"][1]["uuid"])
                end
              else
                if user["children"][1]["children"][1].nil?
                  array.push("No User", "No User", user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"])
                else
                  array.push(user["children"][1]["children"][1]["username"], user["children"][1]["children"][1]["uuid"], user["children"][1]["children"][0]["username"], user["children"][1]["children"][0]["uuid"])
                end
              end
            end
            if user["children"][0]["children"][0].nil?
              array.push("No User", "No User", "No User", "No User")
            else
              if user["children"][0]["children"][0]["left_son"]
                if user["children"][0]["children"][1].nil?
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], "No User", "No User")
                else
                  array.push(user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"], user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"])
                end
              else
                if user["children"][0]["children"][1].nil?
                  array.push("No User", "No User", user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                else
                  array.push(user["children"][0]["children"][1]["username"], user["children"][0]["children"][1]["uuid"], user["children"][0]["children"][0]["username"], user["children"][0]["children"][0]["uuid"])
                end
              end
            end
          end
        end
      end
    end
end
