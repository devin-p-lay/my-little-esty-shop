class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items, source: :invoice_items

  enum status: [ :cancelled, :completed, 'in progress' ]

  validates_presence_of :customer_id,
                        :status

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end