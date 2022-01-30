class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = '購入品を登録しました。'
      redirect_to root_url
    else
      @pagy, @items = pagy(current_user.items.order(id: :desc))
      flash.now[:danger] = '購入品の登録に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = 'レコードを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      flash[:success] = '購入品情報は正常に更新されました。'
      redirect_to root_url
    else
      flash.now[:danger] = '購入品情報は更新できませんでした。'
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:purchase_date, :name, :price)
  end

  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
