require 'rails_helper'

describe 'admin index' do
  before do
    visit '/admin'
  end

  describe 'display' do
    it 'header' do
      expect(page).to have_content('Admin Dashboard')
    end
  end
end 
