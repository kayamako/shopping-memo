class ItemsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit]

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @pagy, @items = pagy(current_user.items.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @item.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      flash[:success] = 'Item は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Item は更新されませんでした'
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
