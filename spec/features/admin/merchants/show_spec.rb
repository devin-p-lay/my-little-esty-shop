require 'rails_helper'

describe 'admin merchant show' do
  before do
    @merchant = create :merchant
    visit admin_merchant_path(@merchant)
  end

  describe 'display' do
    it 'name' do
      expect(page).to have_content(@merchant.name)
    end

    it 'link to update' do
      click_link 'Update'
      expect(current_path).to eq(edit_admin_merchant_path(@merchant))
    end 
  end
end