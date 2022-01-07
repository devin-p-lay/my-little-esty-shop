require 'rails_helper'

describe Customer do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe '#full_name' do
    it 'first and last' do
      customer = build :customer
      expect(customer.full_name).to eq("#{customer.first_name} #{customer.last_name}")
    end
  end 
end