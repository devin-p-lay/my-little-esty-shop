require 'rails_helper'

describe 'admin index' do
  before do
    @merchant1 = create :merchant
    @item1 = create :item, { merchant_id: @merchant1.id }
    @item2 = create :item, { merchant_id: @merchant1.id }

    @customer1 = create :customer
    @customer2 = create :customer
    
    @invoice2 = create :invoice, { customer_id: @customer2.id, status: 1, created_at: "2012-03-24 15:54:10 UTC" }
    @invoice1 = create :invoice, { customer_id: @customer1.id, status: 1, created_at: "2012-03-25 09:54:09 UTC" }
    @invoice3 = create :invoice, { customer_id: @customer2.id, status: 1, created_at: "2012-03-26 15:54:10 UTC" }

    @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, status: 1 }
    @invoice_item2 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item2.id, status: 1 }
    @invoice_item3 = create :invoice_item, { invoice_id: @invoice3.id, item_id: @item1.id, status: 1 }

    @transaction1 = create :transaction, { result: 0, invoice_id: @invoice1.id }
    @transaction2 = create :transaction, { result: 0, invoice_id: @invoice2.id }
    visit '/admin'
  end

  describe 'display' do
    it 'header' do
      expect(page).to have_content('Admin Dashboard')
    end

    it 'link to admin merchants index' do
      click_link 'Admin - Merchants Index'
      expect(current_path).to eq(admin_merchants_path)
    end

    it 'link to admin invoices index' do
      click_link 'Admin - Invoices Index'
      expect(current_path).to eq(admin_invoices_path)
    end

    context 'section for incomplete invoices' do
      it 'lists the ids of invoices that have not been shipped' do
        within("#incomplete_invoices") do
          expect(page).to have_content('Incomplete Invoices:')
          expect(page).to have_content(@invoice1.id)
          expect(page).to have_content(@invoice2.id)
          expect(page).to have_content(@invoice3.id)
        end
      end

      it 'each invoice id links to the admins invoice show page' do
        within("#incomplete_invoices") do
          click_on @invoice1.id
          expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
        end
      end

      it 'display the date the invoice was created' do 
        within("#incomplete_invoices") do 
          expect(page).to have_content("Created: Sunday, March 25, 2012")
          expect(page).to have_content("Created: Saturday, March 24, 2012")
          expect(page).to have_content("Created: Monday, March 26, 2012")
        end
      end 

      it 'invoices listed in order from oldest to newest' do 
        within("#incomplete_invoices") do 
          expect("Created: Saturday, March 24, 2012").to appear_before("Created: Sunday, March 25, 2012")
          expect("Created: Sunday, March 25, 2012").to appear_before("Created: Monday, March 26, 2012")
        end
      end 
    end
  end
end
