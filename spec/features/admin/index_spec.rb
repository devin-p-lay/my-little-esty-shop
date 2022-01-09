require 'rails_helper'

describe 'admin index' do
  before do
    visit '/admin'
  end

  describe 'display' do
    it 'header' do
      expect(page).to have_content('Admin Dashboard')
    end

    it 'link to admin merchants index' do
      click_link 'Admin - Merchants Index'
      expect(current_path).to eq(admin_merchants_path)
    end

    it 'link to admin invoices index' do
      click_link 'Admin - Invoices Index'
      expect(current_path).to eq(admin_invoices_path)
    end
  end
end
