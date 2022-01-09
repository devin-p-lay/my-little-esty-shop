class Admin::MerchantStatusController < ApplicationController
  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_status_params)
    redirect_to admin_merchants_path
  end

    private

      def merchant_status_params
        params.permit(:status)
      end
end