class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new; end

  def create
    merchant = Merchant.new(merchant_params)
    redirect_to admin_merchants_path if merchant.save
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(name: params[:name])
    @merchant.save
    flash[:message] = '-- Successfully updated merchant --'
    redirect_to admin_merchant_path(@merchant)
  end

    private

      def merchant_params
        params.permit(:id, :name, :status)
      end
end
