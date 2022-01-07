class InvoicesController < ApplicationController
  before_action :do_merchant, only: [:index]

  def index
    @invoices = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_item 
  end
end
