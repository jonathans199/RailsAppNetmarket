# == Schema Information
#
# Table name: server_configs
#
#  id          :integer          not null, primary key
#  hostname    :string
#  username    :string
#  password    :string
#  port        :string
#  foldername  :string
#  server_port :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ServerConfig < ApplicationRecord
end
