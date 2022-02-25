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
  end
end
