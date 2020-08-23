class User < ActiveRecord::Base
  include Laters::Concern

  def crash
    raise Laters::Error
  end

  def upcase!
    update! name: name.upcase
  end
end
