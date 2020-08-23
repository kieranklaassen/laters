class User < ActiveRecord::Base
  include RunLater::Concern

  def crash
    raise RunLater::Error
  end

  def upcase!
    update! name: name.upcase
  end
end
