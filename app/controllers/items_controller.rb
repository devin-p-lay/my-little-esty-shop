class ItemsController < ApplicationController
  before_action :current_merchant

  def index
    @items = @merchant.items
  end

  def show
    @item = @merchant.items.find(params[:id])
  end
end