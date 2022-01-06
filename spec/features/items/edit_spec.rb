require 'rails_helper'

describe 'edit merchant item' do
  before do
    @merchant = create :merchant
    @item = create :item, { merchant_id: @merchant.id }
    visit edit_merchant_item_path(@merchant, @item)
  end

  describe 'form to edit item' do
    describe 'display form with prepopulated fields' do
      it 'can update an item' do
        within '#form' do
          expect(find_field('item_name').value).to eq(@item.name)

          fill_in 'Name', with: 'Important Item'

          click_button 'Submit'
        end

        expect(current_path).to eq(merchant_item_path(@merchant, @item))
        expect(page).to have_content('Important Item')
        expect(page).to have_content('Successfully Updated Item')
      end

      it 'handles incorrect form submission' do
        within '#form' do
          expect(find_field('item_name').value).to eq(@item.name)
          fill_in 'Name', with: ''
          click_button 'Submit'
        end

        within '#form' do
          expect(find_field('item_name').value).to eq(@item.name)
        end

        expect(page).to have_content('Nope')
      end
    end
  end
end

