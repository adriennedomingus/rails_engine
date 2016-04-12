require 'rails_helper'

RSpec.describe "Transaction endpoint" do
  it "returns a hash of all transactions" do
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the merchant")
    invoice1 = customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    invoice2 = customer2.invoices.create(merchant_id: merchant.id, status: "shipped")
    invoice3 = customer.invoices.create(merchant_id: merchant2.id, status: "shipped")
    t1 = invoice1.transactions.create(credit_card_number: "3333333333333333")
    t2 = invoice2.transactions.create(credit_card_number: "4444444444444444")
    t3 = invoice3.transactions.create(credit_card_number: "5555555555555555")

    get "/api/v1/transactions.json"
    result = JSON.parse(response.body)

    expect(result.first["credit_card_number"]).to eq(t1.credit_card_number)
    expect(result[2]["invoice_id"]).to eq(t3.invoice_id)
  end

  it "returns a specific transaction" do

    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    merchant = Merchant.create(name: "the merchant")
    invoice1 = customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    invoice2 = customer2.invoices.create(merchant_id: merchant.id, status: "shipped")
    invoice1.transactions.create(credit_card_number: "3333333333333333")
    t2 = invoice2.transactions.create(credit_card_number: "4444444444444444")

    get "/api/v1/transactions/#{t2.id}.json"
    result = JSON.parse(response.body)

    expect(result["invoice_id"]).to eq(invoice2.id)
    expect(result["credit_card_number"]).to eq(t2.credit_card_number)

  end
end
