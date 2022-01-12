require 'rails_helper'

describe 'admin invoice show' do
  before do
    @merchant = create :merchant
    @customer = create :customer
    @invoice = create :invoice, { customer_id: @customer.id, status: 'in progress'}
    @invoice2 = create :invoice
    @item1 = create :item, { merchant_id: @merchant.id }
    @item2 = create :item, { merchant_id: @merchant.id }
    @item3 = create :item
    @invoice_item1 = create :invoice_item, { invoice_id: @invoice.id, item_id: @item1.id, quantity: 2, unit_price: 1_500 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice.id, item_id: @item2.id, quantity: 3, unit_price: 2_000}
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item3.id }

    visit admin_invoice_path(@invoice)
  end

  describe 'display' do
    it 'invoice info' do
      expect(page).to have_content(@invoice.id)
      within '#invoice-attr' do
        expect(page).to have_content(@invoice.status)
        expect(page).to have_content("Created on: #{@invoice.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content(@invoice.customer.full_name)
      end
    end

    it 'total revenue' do
      within '#invoice-attr' do
        expect(page).to have_content("Total Revenue: $90.00")
      end
    end

    it 'select update invoice status' do
      expect(@invoice.status).to eq('in progress')
      within("#status-update") do
        select "completed", from: "invoice_status"
        click_button('Update Invoice')
        @invoice.reload
        expect(@invoice.status).to eq('completed')
      end
      expect(current_path).to eq(admin_invoice_path(@invoice))
      expect(page).to have_content('Invoice Status: completed')
    end

    describe 'invoice items' do
      it 'all items on the invoice' do
        expect(page).to have_content(@invoice_item1.item.name)
        expect(page).to have_content(@invoice_item2.item.name)
        expect(page).to_not have_content(@invoice_item3.item.name)
      end

      it 'info' do
        expect(page).to have_content(@invoice_item1.item.name)
        expect(page).to have_content(@invoice_item1.quantity)
        expect(page).to have_content("Price: $#{@invoice_item1.unit_price.fdiv(100)}")
        expect(page).to have_content(@invoice_item1.status)
      end
    end
  end
end