class ItemsController < ApplicationController
  before_action :current_merchant

  def index
    @items = @merchant.items
  end
end