require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant1 = Merchant.create(name: "Harry's")
    @merchant2 = Merchant.create(name: "Sally's")

    visit merchant_dashboard_index_path(@merchant1)
  end

  describe 'display' do
    it 'name of merchant' do
      expect(page).to have_content(@merchant1.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    it 'link to Merchant Items Index' do
      click_link 'Merchant Items'
      expect(current_path).to eq(merchant_items_path(@merchant1))
    end

    it 'link to Merchant Invoices Index' do
      click_link 'Merchant Invoices'
      expect(current_path).to eq(merchant_invoices_path(@merchant1))
    end
  end
end