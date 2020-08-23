class Comment < ActiveRecord::Base
  include Laters::Concern
  run_in_queue :low

  def call_me
    puts 'Hi'
  end
end
