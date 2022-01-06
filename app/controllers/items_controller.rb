class ItemsController < ApplicationController
  before_action :do_merchant
  before_action :do_item, only: %i[ show edit update ]

  def index
    @items = @merchant.items
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:success] = 'Successfully Updated Item'
      redirection
    else
      flash[:alert] = 'Nope'
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end

    private

      def do_item
        @item = Item.find(params[:id])
      end

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :status)
      end

      def redirection
        # if params[:item][:status].present?
        #   redirect_to merchant_items_path(@merchant)
        # else
          redirect_to merchant_item_path(@merchant, @item)
        # end
      end
end