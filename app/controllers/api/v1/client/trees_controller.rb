class Api::V1::Client::TreesController < ApplicationController
  # show current user tree
  def show_user_subtree
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
      matrix
    end

    def fetch_user(array)
      array = "#{@current_user.id},#{array}"
      array = array.split(",").map{ |x|
        User.where(id:x).select(:uuid,:username).last
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
