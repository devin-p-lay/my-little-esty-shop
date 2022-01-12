class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices, source: :invoice_items
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: { enabled: 0, disabled: 1 }

  scope :by_status, lambda  { |status| where(status: status) }
end