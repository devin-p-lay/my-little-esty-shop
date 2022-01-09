require 'rails_helper'

describe 'admin invoice show' do
  before do
    @invoice = create :invoice
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
  end
end