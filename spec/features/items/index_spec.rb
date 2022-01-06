require 'rails_helper'

describe 'Merchant Items Index' do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant
    @item1 = create :item, { merchant_id: @merchant.id, status: 'enabled' }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    visit merchant_items_path(@merchant)
  end

  describe 'display' do
    it 'all item names' do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to_not have_content(@item3.name)
    end
  end
end