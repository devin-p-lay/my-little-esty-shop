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
  end
end