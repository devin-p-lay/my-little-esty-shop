require 'rails_helper'

describe 'new admin merchant' do
  before do
    visit new_admin_merchant_path(@merchant)
  end

  describe 'form' do
    it 'can create a new merchant' do
      fill_in 'Name', with: 'Chuck Morse'
      click_on 'Create'
      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content('Chuck Morse')
    end
  end
end