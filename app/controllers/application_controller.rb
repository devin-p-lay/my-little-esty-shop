class ApplicationController < ActionController::Base
  def current_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
