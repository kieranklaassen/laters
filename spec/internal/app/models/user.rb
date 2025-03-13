class User < ActiveRecord::Base
  include Laters::Concern
  
  # Define callbacks for testing
  before_laters :log_before
  after_laters :log_after
  around_laters :log_around
  
  attr_accessor :callback_log
  
  def initialize(*args)
    super
    @callback_log = []
  end

  def crash
    raise Laters::Error
  end

  def upcase!
    update! name: name.upcase
  end
  
  def greet(name, title: nil)
    title.nil? ? "Hello #{name}" : "Hello #{title} #{name}"
  end
  
  private
  
  def log_before
    @callback_log ||= []
    @callback_log << "before"
  end
  
  def log_after
    @callback_log ||= []
    @callback_log << "after"
  end
  
  def log_around
    @callback_log ||= []
    @callback_log << "around_before"
    yield
    @callback_log << "around_after"
  end
end
