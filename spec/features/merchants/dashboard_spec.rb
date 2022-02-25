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

    describe 'Top 5 customers' do
      it "lists top 5 customers and number of successful transactions for each customer" do
        merchant1 = Merchant.create!(name: 'merchant1')
        item1 = create(:item, merchant_id: merchant1.id, unit_price: 5, name: 'item1_name')

        customer1 = create(:customer)
        invoice1 = create(:invoice, customer_id: customer1.id)
        transaction_list1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice1.id, result: 0)
        invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, status: 2, quantity: 1, unit_price: 1)

        customer2 = create(:customer)
        invoice2 = create(:invoice, customer_id: customer2.id)
        transaction_list2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice2.id, result: 0)
        invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, status: 2, quantity: 1, unit_price: 1)

        customer3 = create(:customer)
        invoice3 = create(:invoice, customer_id: customer3.id)
        transaction_list3 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice3.id, result: 0)
        invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice3.id, status: 2, quantity: 1, unit_price: 1)

        customer4 = create(:customer)
        invoice4 = create(:invoice, customer_id: customer4.id)
        transaction_list4 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice4.id, result: 0)
        invoice_item4 = create(:invoice_item, item_id: item1.id, invoice_id: invoice4.id, status: 2, quantity: 1, unit_price: 1)

        customer5 = create(:customer)
        invoice5 = create(:invoice, customer_id: customer5.id)
        transaction_list5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice5.id, result: 0)
        invoice_item5 = create(:invoice_item, item_id: item1.id, invoice_id: invoice5.id, status: 2, quantity: 1, unit_price: 1)

        customer6 = create(:customer)
        invoice6 = create(:invoice, customer_id: customer6.id)
        transaction_list6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice6.id, result: 0)
        invoice_item6 = create(:invoice_item, item_id: item1.id, invoice_id: invoice6.id, status: 2, quantity: 1, unit_price: 1)

        visit "/merchants/#{merchant1.id}/dashboard"

        within("#top_five_customers") do
          expect(page).to have_content("Customer: #{customer1.full_name} - Total Transactions: 6")
          expect(page).to have_content("Customer: #{customer2.full_name} - Total Transactions: 5")
          expect(page).to have_content("Customer: #{customer4.full_name} - Total Transactions: 4")
          expect(page).to have_content("Customer: #{customer3.full_name} - Total Transactions: 3")
          expect(page).to have_content("Customer: #{customer5.full_name} - Total Transactions: 2")
          expect(page).to_not have_content("Customer: #{customer6.full_name} - Total Transactions: 1")

          expect(customer1.full_name).to appear_before(customer2.full_name)
          expect(customer2.full_name).to appear_before(customer4.full_name)
          expect(customer4.full_name).to appear_before(customer3.full_name)
          expect(customer3.full_name).to appear_before(customer5.full_name)
        end
      end
    end
  end
end