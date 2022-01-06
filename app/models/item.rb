class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  enum status: { disabled: 0, enabled: 1 }

  scope :by_status, lambda { |status|
    where(status: status)
  }
end