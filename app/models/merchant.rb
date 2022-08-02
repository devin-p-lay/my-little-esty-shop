class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  enum status: { enabled: 0, disabled: 1 }

  scope :by_status, lambda  { |status| where(status: status) }

  def ordered_items_to_ship
    invoice_items.joins(:invoice).where(status: [0, 1]).order('invoices.created_at')
  end

  def top_five_customers
    customers.joins(invoices: :transactions)
              .where(transactions: { result: 0 })
              .select('customers.*, count(transactions.*) as total_transactions')
              .order(total_transactions: :desc)
              .group('customers.id')
              .limit(5)
  end
end