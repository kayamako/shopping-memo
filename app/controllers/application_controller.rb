class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def count_items(user)
    @count_items = user.items.count
  end
  
  def sum_prices(user)
    @sum_prices = user.items.sum(:price)
  end
  
end