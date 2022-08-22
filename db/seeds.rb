# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Item.destroy_all
Invoice.destroy_all
Transaction.destroy_all
Customer.destroy_all
Merchant.destroy_all

@merchant = Merchant.create(name: "Dev'n Peelay")
@item1 = Item.create(name: "Tool A", description: "Tool used for 'A' things", unit_price: 500, merchant_id: @merchant.id)
@item2 = Item.create(name: "Tool B", description: "Tool used for 'B' things", unit_price: 600, merchant_id: @merchant.id)

@customer1 = Customer.create(first_name: "Barry", last_name: "Burley")
@invoice1 = @customer1.invoices.create(status: 1)
@invoice_item1 = InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id)
@transaction1 = Transaction.create(result: 0, invoice_id: @invoice1.id)

@customer2 = Customer.create(first_name: "Curtis", last_name: "Curley")
@invoice2 = @customer2.invoices.create(status: 1)
@invoice_item2 = InvoiceItem.create(item_id: @item2.id, invoice_id: @invoice2.id)
@transaction2 = Transaction.create(result: 0, invoice_id: @invoice2.id)

@customer3 = Customer.create(first_name: "Daisy", last_name: "Durley")
@invoice3 = @customer3.invoices.create(status: 0)
@invoice_item3 = InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice3.id, status: 1)
@transaction3 = Transaction.create(result: 0, invoice_id: @invoice3.id)