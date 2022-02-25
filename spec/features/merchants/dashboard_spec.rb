require 'rails_helper'

describe 'Merchant Dashboard' do
  before do
    @merchant = create :merchant
    @merchant2 = create :merchant
    @customer = create :customer
    @item1 = create :item, { merchant_id: @merchant.id }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item, { merchant_id: @merchant.id }
    @invoice1 = create :invoice, { id: 1, customer_id: @customer.id }
    @invoice2 = create :invoice, { customer_id: @customer.id }
    @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, quantity: 1, unit_price: 10, status: 0 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item2.id, quantity: 1, unit_price: 20, status: 1 }
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item3.id, quantity: 1, unit_price: 30, status: 2 }

    visit merchant_dashboard_index_path(@merchant)
  end

  describe 'display' do
    it 'name of merchant' do
      expect(page).to have_content(@merchant.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    it 'link to Merchant Items Index' do
      click_link 'Merchant Items'
      expect(current_path).to eq(merchant_items_path(@merchant))
    end

    it 'link to Merchant Invoices Index' do
      click_link 'Merchant Invoices'
      expect(current_path).to eq(merchant_invoices_path(@merchant))
    end

    describe 'section for items ready to ship' do
      it 'list items, with their invoice id, that have not been shipped, in order' do
        within("#items_ready_to_ship") do
          expect(page).to have_content('Items Ready to Ship:')
          expect(page).to have_content(@item1.name)
          expect(page).to have_content(@item1.invoice_ids[0])
          expect(page).to have_content(@item2.name)
          expect(page).to have_content(@item2.invoice_ids[0])
          expect(page).to_not have_content(@item3.name)
          expect(page).to_not have_content(@item3.invoice_ids[0])
        end
      end

      it 'each invoice id is a link to merchant invoice show' do
        within("#items_ready_to_ship") do
          click_link(@invoice1.id, match: :first)
          expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice1))
        end
      end
    end
  end
end