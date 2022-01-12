require 'rails_helper'

describe 'admin invoices index' do
  before do
    @invoice1 = create :invoice
    @invoice2 = create :invoice
    @invoice3 = create :invoice
    visit admin_invoices_path
  end

  describe 'display' do
    it 'all invoices' do
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice2.id)
      expect(page).to have_content(@invoice3.id)
    end

    it 'each id as a link to admin invoice show' do
      click_on "#{@invoice1.id}"
      expect(current_path).to eq(admin_invoice_path(@invoice1))
    end
  end
end