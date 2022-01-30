class ToppagesController < ApplicationController
  def index
    if logged_in?
      @item = current_user.items.build  # form_with 用
      @pagy, @items = pagy(current_user.items.order(purchase_date: :desc))
      @count_items = count_items(current_user)
      @sum_prices = sum_prices(current_user)
    end
  end
end
