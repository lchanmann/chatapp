class HomeController < ApplicationController
  def index
    @username = cookies.signed[:current_username] ||= assign_username
  end

  private
    def assign_username
      user_id = REDIS.incr('user_count')
      "User#{user_id}"
    end
end
