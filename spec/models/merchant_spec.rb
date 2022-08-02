require 'rails_helper'

describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'model methods' do
    describe '#ready_to_ship' do
      it 'returns items that have been ordered and have not yet been shipped' do
        merchant = create :merchant
        item1 = create :item, { merchant_id: merchant.id }
        item2 = create :item, { merchant_id: merchant.id }
        item3 = create :item, { merchant_id: merchant.id }

        customer = create :customer
        invoice = create :invoice, { customer_id: customer.id }

        invoice_item1 = create :invoice_item, { invoice_id: invoice.id, item_id: item1.id, status: 0 }
        invoice_item2 = create :invoice_item, { invoice_id: invoice.id, item_id: item2.id, status: 1 }
        invoice_item3 = create :invoice_item, { invoice_id: invoice.id, item_id: item3.id, status: 2 }

        expect(merchant.ordered_items_to_ship).to eq([invoice_item1, invoice_item2])
      end
    end

    it '#top_five_customers' do
      merchant1 = create(:merchant)
      item = create(:item, merchant_id: merchant1.id)
      # customer1, 6 succesful transactions and 1 failed
      customer1 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item1 = create(:invoice_item, item_id: item.id, invoice_id: invoice1.id, status: 2)
      transactions_list1 = FactoryBot.create_list(:transaction, 6, invoice_id: invoice1.id, result: 0)
      failed1 = create(:transaction, invoice_id: invoice1.id, result: 1)
      # customer2 5 succesful transactions
      customer2 = create(:customer)
      invoice2 = create(:invoice, customer_id: customer2.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item2 = create(:invoice_item, item_id: item.id, invoice_id: invoice2.id, status: 2)
      transactions_list2 = FactoryBot.create_list(:transaction, 5, invoice_id: invoice2.id, result: 0)
      #customer3 4 succesful transactions
      customer3 = create(:customer)
      invoice3 = create(:invoice, customer_id: customer3.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item3 = create(:invoice_item, item_id: item.id, invoice_id: invoice3.id, status: 2)
      transactions_list3 = FactoryBot.create_list(:transaction, 4, invoice_id: invoice3.id, result: 0)
      #customer4 3 succesful transactions
      customer4 = create(:customer)
      invoice4 = create(:invoice, customer_id: customer4.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item4 = create(:invoice_item, item_id: item.id, invoice_id: invoice4.id, status: 2)
      transactions_list4 = FactoryBot.create_list(:transaction, 3, invoice_id: invoice4.id, result: 0)
      #customer5 2 succesful transactions
      customer5 = create(:customer)
      invoice5 = create(:invoice, customer_id: customer5.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item5 = create(:invoice_item, item_id: item.id, invoice_id: invoice5.id, status: 2)
      transactions_list5 = FactoryBot.create_list(:transaction, 2, invoice_id: invoice5.id, result: 0)
      #customer6 1 succesful transactions
      customer6 = create(:customer)
      invoice6 = create(:invoice, customer_id: customer6.id, created_at: "2012-03-25 09:54:09 UTC")
      invoice_item6 = create(:invoice_item, item_id: item.id, invoice_id: invoice6.id, status: 2)
      transactions_list6 = FactoryBot.create_list(:transaction, 1, invoice_id: invoice6.id, result: 0)

      expect(merchant1.top_five_customers).to eq([customer1, customer2, customer3, customer4, customer5])
    end
  end
end
