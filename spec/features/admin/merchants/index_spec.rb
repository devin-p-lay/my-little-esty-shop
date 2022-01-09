require 'rails_helper'

describe 'admin merchants index' do
  before do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @merchant3 = create :merchant
    visit admin_merchants_path
  end

  describe 'display' do
    it 'all merchants' do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
    end

    it 'name is link to admin merchant show' do
      click_link "#{@merchant3.name}"
      expect(current_path).to eq(admin_merchant_path(@merchant3))
    end 
  end
end