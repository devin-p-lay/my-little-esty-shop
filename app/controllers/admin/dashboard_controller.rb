class Admin::DashboardController < ApplicationController
  def index
    @invoices = Invoice.all.incomplete_invoices
  end
end