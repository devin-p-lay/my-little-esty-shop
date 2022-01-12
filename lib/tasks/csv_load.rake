require 'csv'

namespace :csv_load do
  task customers: :environment do
    Customer.destroy_all
    CSV.foreach('./db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  task merchants: :environment do
    Merchant.destroy_all
    CSV.foreach('./db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    CSV.foreach('./db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  task invoices: :environment do
    Invoice.destroy_all
    CSV.foreach('./db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  task items: :environment do
    Item.destroy_all
    CSV.foreach('./db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  task transactions: :environment do
    Transaction.destroy_all
    CSV.foreach('./db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  task :all do
    tables = [:customers, :merchants, :invoices, :items, :invoice_items, :transactions]
    tables.each do |table|
      Rake::Task["csv_load:#{table}"].invoke
    end
  end
end