require 'rails_helper'

describe 'new merchant item' do
  before do
    @merchant = create :merchant
    @item1 = create :item, { merchant_id: @merchant.id }
    visit new_merchant_item_path(@merchant)
  end

  describe 'form to create new item' do
    it 'creates disabled and redirects to index' do
      fill_in 'Name', with: 'Important Item'
      fill_in 'Description', with: 'There are many like it but this one is mine'
      fill_in 'Unit Price', with: 2

      click_button 'Submit'
      @merchant.reload

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(Item.last.name).to eq('Important Item')
      expect(page).to have_content('Important Item')
      expect(Item.last.status).to eq('disabled')
    end
  end
end