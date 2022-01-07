class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :first_name,
                        :last_name

  def full_name
    "#{first_name} #{last_name}"
  end
end