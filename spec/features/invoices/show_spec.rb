require 'rails_helper'

describe 'merchant invoice show' do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant

    @customer = create :customer

    @invoice1 = create :invoice, { customer_id: @customer.id, created_at: DateTime.new(2021, 9, 11) }
    @invoice2 = create :invoice, { customer_id: @customer.id, created_at: DateTime.new(2021, 9, 17) }

    @item1 = create :item, { merchant_id: @merchant.id, status: 'enabled' }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant2.id }

    @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, unit_price: 50, quantity: 1, status: 0 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item2.id, unit_price: 100, quantity: 1, status: 1 }
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item3.id, unit_price: 200, quantity: 1, status: 2 }

    visit merchant_invoice_path(@merchant, @invoice1)
  end

  describe 'display' do
    it 'invoice attributes' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content('Saturday, September 11, 2021')
      expect(page).to have_content(@invoice1.customer.full_name)
      expect(page).to_not have_content(@invoice2)
    end

    describe 'total revenue' do
      it 'revenue of all items on invoice' do
        expect(page).to have_content("Total Revenue: $1.50")
      end
    end

    describe 'invoice items' do
      it 'lists all invoice item names, quantity, price and status' do
        within "#invoice_item-#{@invoice_item1.id}" do
          expect(page).to have_content(@invoice_item1.item.name)
          expect(page).to have_content(@invoice_item1.quantity)
          expect(page).to have_content(@invoice_item1.unit_price)
          expect(page).to have_content(@invoice_item1.status)
          expect(page).to_not have_content(@item3)
        end
      end

      it 'select update invoice item status' do
        within "#invoice_item-#{@invoice_item2.id}" do
          expect(find_field('invoice_item_status').value).to eq('pending')
          select 'packaged'
          click_button 'Update Invoice'
        end
        expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))

        within "#invoice_item-#{@invoice_item1.id}" do
          expect(find_field('invoice_item_status').value).to eq('packaged')
          expect(page).to have_content('packaged')
        end
      end
    end
  end
end