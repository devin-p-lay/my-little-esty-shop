require 'rails_helper'

describe 'Merchant Item Show' do
  before do
    @merchant = create :merchant
    @item = create :item, { merchant_id: @merchant.id }

    visit merchant_item_path(@merchant, @item)
  end

  describe 'display' do
    it 'attributes' do
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.unit_price.fdiv(100))
    end

    it 'link to update item' do
      click_link 'Update'
      expect(current_path).to eq(edit_merchant_item_path(@merchant, @item))
    end
  end
end