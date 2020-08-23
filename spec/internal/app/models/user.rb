class User < ActiveRecord::Base
  include RunLater::Concern
end
