class Comment < ActiveRecord::Base
  include RunLater::Concern
  run_in_queue :low

  def call_me
    puts 'Hi'
  end
end
