require 'rails_helper'

RSpec.describe "Invoice endpoint" do
  it "returns a hash of all invoices" do
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other", last_name: "other last")
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the merchant")
    customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    customer2.invoices.create(merchant_id: merchant.id, status: "shipped")
    customer.invoices.create(merchant_id: merchant2.id, status: "shipped")

    get "/api/v1/invoices.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
    expect(result.first["status"]).to eq("shipped")
    expect(result[2]["merchant_id"]).to eq(merchant2.id)
    expect(result[1]["customer_id"]).to eq(customer2.id)
  end

  it "returns a specific invoice" do
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other name", last_name: "last name")
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the merchant")
    customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    i2 = customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")

    get "/api/v1/invoices/#{i2.id}.json"
    result = JSON.parse(response.body)

    expect(result["customer_id"]).to eq(customer2.id)
    expect(result["merchant_id"]).to eq(merchant2.id)
    expect(result["status"]).to eq("shipped")
  end

  it "returns a random invoice" do
    customer = Customer.create(first_name: "adrienne", last_name: "domingus")
    customer2 = Customer.create(first_name: "other name", last_name: "last name")
    merchant = Merchant.create(name: "the merchant")
    merchant2 = Merchant.create(name: "the merchant")
    customer.invoices.create(merchant_id: merchant.id, status: "shipped")
    customer2.invoices.create(merchant_id: merchant2.id, status: "shipped")

    get "/api/v1/invoices/random.json"
    expect(response.status).to eq(200)
  end

  it "returns customer associted with an invoice" do
    m = Merchant.create(name: "merchant")
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")
    c3 = Customer.create(first_name: "name", last_name: "last name")
    c3.invoices.create(merchant_id: m.id, status: "success")
    i2 = c3.invoices.create(merchant_id: m.id, status: "success")
    c2.invoices.create(merchant_id: m.id, status: "success")

    get "/api/v1/invoices/#{i2.id}/customer"
    result = JSON.parse(response.body)
    expect(result["id"]).to eq(c3.id)
  end

  it "returns merchant associated with an invoice" do
    m = Merchant.create(name: "merchant")
    m2= Merchant.create(name: "merchant2")
    c3 = Customer.create(first_name: "name", last_name: "last name")
    c3.invoices.create(merchant_id: m.id, status: "success")
    i = c3.invoices.create(merchant_id: m.id, status: "success")
    c3.invoices.create(merchant_id: m.id, status: "success")

    get "/api/v1/invoices/#{i.id}/merchant"
    result = JSON.parse(response.body)
    expect(result["id"]).to eq(m.id)
  end
end
