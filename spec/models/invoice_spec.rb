require 'rails_helper'

describe Invoice do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :status }
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'it totals revenue of all items on an invoice' do
        merchant = create :merchant
        item1    = create :item, { merchant_id: merchant.id, unit_price: 10 }
        item2    = create :item, { merchant_id: merchant.id, unit_price: 5 }
        customer = create :customer
        invoice  = create :invoice, { customer_id: customer.id }
        ii1      = create :invoice_item, { invoice_id: invoice.id, item_id: item1.id, quantity: 2, unit_price: 10 }
        ii2      = create :invoice_item, { invoice_id: invoice.id, item_id: item2.id, quantity: 1, unit_price: 5 }

        expect(invoice.total_revenue).to eq(25)
      end
    end
  end
end