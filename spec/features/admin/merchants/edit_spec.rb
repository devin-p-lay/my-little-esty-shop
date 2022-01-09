require 'rails_helper'

describe 'admin edit merchant' do
  before do
    @merchant = create :merchant
    visit edit_admin_merchant_path(@merchant)
  end

  describe 'form' do
    describe 'display' do
      it 'prefilled with current attributes' do
        expect(find_field('name').value).to eq(@merchant.name)
      end
    end

    it 'can update merchant' do
      fill_in 'Name', with: 'Chuck Norris Clicks Bruce Lee Inc.'
      click_button 'Submit'

      expect(current_path).to eq(admin_merchant_path(@merchant))
      expect(page).to have_content('Chuck Norris Clicks Bruce Lee Inc.')
      expect(page).to have_content('Successfully updated merchant')
    end
  end
end