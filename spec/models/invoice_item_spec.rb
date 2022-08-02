require 'rails_helper'

describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end

  context "class_methods" do
    describe ".incomplete_invoices" do
      it "only shows invoices that have not been shipped" do
        @merchant1 = create :merchant
        @item1 = create :item, { merchant_id: @merchant1.id }
        @item2 = create :item, { merchant_id: @merchant1.id }

        @customer1 = create :customer
        @invoice1 = create :invoice, { customer_id: @customer1.id, status: 1 }

        @customer2 = create :customer
        @invoice2 = create :invoice, { customer_id: @customer2.id, status: 1 }

        @invoice_item1 = create :invoice_item, { invoice_id: @invoice1.id, item_id: @item1.id, status: 2 }
        @invoice_item2 = create :invoice_item, { invoice_id: @invoice2.id, item_id: @item2.id, status: 1 }

        @transaction1 = create :transaction, { result: 0, invoice_id: @invoice1.id }
        @transaction2 = create :transaction, { result: 0, invoice_id: @invoice2.id }

        expect(InvoiceItem.incomplete_invoices).to eq([@invoice2.id])
      end
    end
  end
end