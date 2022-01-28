class ItemsController < ApplicationController
  before_action :do_merchant
  before_action :do_item, only: %i[ show edit update ]

  def index
    @items = @merchant.items
  end

  def show; end

  def edit; end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params.merge({ id: Item.next_id, merchant_id: params[:merchant_id] }))
    redirect_to merchant_items_path(@merchant) if item.save
  end

  def update
    if @item.update(item_params)
      flash[:message] = '-- Successfully Updated Item --'
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:message] = '** Nope **'
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

    private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :status)
      end

      # def redirection
      #   if params[:item][:status].present?
      #     redirect_to merchant_items_path(@merchant)
      #   else
      #     redirect_to merchant_item_path(@merchant, @item)
      #   end
      # end
end