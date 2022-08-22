class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :invoice_items

  enum status: [ :cancelled, 'in progress', :completed ]

  validates_presence_of :customer_id,
                        :status

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.incomplete_invoices
    where(:invoices => {status: [0,1]}).order(created_at: :asc)
  end
end