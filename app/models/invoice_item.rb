class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: [ :packaged, :pending, :shipped ]

  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  def self.incomplete_invoices
    where.not(status: '2').distinct.pluck(:invoice_id)
  end
end