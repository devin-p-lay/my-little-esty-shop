require 'rails_helper'

describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
    it 'validates default disabled status' do
      item = create :item
      expect(item.status).to eq('disabled')
    end
  end

  describe 'class methods' do
    before do
      @merchant = create :merchant, { id: 20 }
      @item1 = create :item, { merchant_id: @merchant.id, status: 'enabled' }
      @item2 = create :item, { merchant_id: @merchant.id }
      @item3 = create :item, { merchant_id: @merchant.id }
      @item4 = create :item, { merchant_id: @merchant.id }
    end

    describe '::by_status()' do
      it 'returns items by status disabled' do
        expect(@merchant.items.by_status('disabled')).to eq([@item2, @item3, @item4])
      end
      it 'returns items by status enabled' do
        expect(@merchant.items.by_status('enabled')).to eq([@item1])
      end
    end

    describe '::next_id' do
      it 'sequential id number' do
        expect(Item.next_id).to eq(Item.maximum(:id).next)
      end

      it 'first item' do
        Item.destroy_all
        @test_merchant = create :merchant
        @first_item = create :item, { merchant_id: @test_merchant.id, id: Item.next_id }

        expect(@test_merchant.items.last.id).to eq(1)
      end
    end
  end
end