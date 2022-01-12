require 'rails_helper'

describe 'admin merchants index' do
  before do
    @merchant1 = create :merchant
    @merchant2 = create :merchant
    @merchant3 = create :merchant
    visit admin_merchants_path
  end

  describe 'display' do
    it 'all merchants' do
      expect(page).to have_content(@merchant1.name)
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_content(@merchant3.name)
    end

    it 'name is link to admin merchant show' do
      click_link "#{@merchant3.name}"
      expect(current_path).to eq(admin_merchant_path(@merchant3))
    end

    it 'button to enable/disable next to merchant' do
      expect(@merchant2.status).to eq('enabled')

      within '#enabled' do
        click_button "Disable #{@merchant2.name}"

        @merchant2.reload
        expect(@merchant2.status).to eq('disabled')
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_no_button("Disable #{@merchant2.name}")
      end

      within '#disabled' do
        click_button "Enable #{@merchant2.name}"

        @merchant2.reload
        expect(@merchant2.status).to eq('enabled')
        expect(current_path).to eq(admin_merchants_path)
        expect(page).to have_no_button("Disable #{@merchant2.name}")
      end
    end

    it 'link to create new merchant' do
      click_link 'Create New Merchant'
      expect(current_path).to eq(new_admin_merchant_path)
    end
  end
end