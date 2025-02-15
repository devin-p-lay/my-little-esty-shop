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

    it 'name as a link to show page' do
      click_link @item1.name
      expect(current_path).to eq(merchant_item_path(@merchant, @item1))
    end

    it 'disable and enable button' do
      click_button "Enable #{@item2.name}"
      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_no_button("Enable #{@item2.name}")
      expect(page).to have_button("Disable #{@item2.name}")

      click_button "Disable #{@item2.name}"

      expect(current_path).to eq(merchant_items_path(@merchant))
      expect(page).to have_no_button("Disable #{@item2.name}")
    end

    it 'has a disable and enable section' do
      within '#enabled' do
        expect(page).to have_button("Disable #{@item1.name}")
        expect(page).to have_no_button("Enable #{@item1.name}")
      end

      within '#disabled' do
        expect(page).to have_button("Enable #{@item2.name}")
        expect(page).to have_no_button("Disable #{@item2.name}")
      end
    end

    it 'link to create new item' do
      click_link 'Create Item'

      expect(current_path).to eq(new_merchant_item_path(@merchant))
    end
  end
end