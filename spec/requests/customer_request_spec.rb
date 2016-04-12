require 'rails_helper'

RSpec.describe "Customer endpoint" do
  it "returns a hash of all customers" do
    c1 = Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")
    c3 = Customer.create(first_name: "name", last_name: "last name")

    get "/api/v1/customers.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(3)
    expect(result.first["first_name"]).to eq(c1.first_name)
    expect(result[2]["id"]).to eq(c3.id)
    expect(result[1]["last_name"]).to eq(c2.last_name)
  end

  it "returns specific customer" do
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")

    get "/api/v1/customers/#{c2.id}.json"
    result = JSON.parse(response.body)

    expect(result["first_name"]).to eq(c2.first_name)
    expect(result["last_name"]).to eq(c2.last_name)
  end

  it "finds customer by id" do
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")

    get "/api/v1/customers/find?id=#{c2.id}"
    result = JSON.parse(response.body)

    expect(result["first_name"]).to eq(c2.first_name)
    expect(result["last_name"]).to eq(c2.last_name)
  end

  it "finds by first name case insensitive" do
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")

    get "/api/v1/customers/find?first_name=JUSTin"
    result = JSON.parse(response.body)

    expect(result["first_name"]).to eq(c2.first_name)
    expect(result["last_name"]).to eq(c2.last_name)
  end

  it "finds by last name" do
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "other last")

    get "/api/v1/customers/find?last_name=#{c2.last_name}"
    result = JSON.parse(response.body)

    expect(result["first_name"]).to eq(c2.first_name)
    expect(result["last_name"]).to eq(c2.last_name)
  end

  it "returns a random customer" do
    Customer.create(first_name: "adrienne", last_name: "domingus")
    Customer.create(first_name: "justin", last_name: "domingus")
    Customer.create(first_name: "name", last_name: "last name")

    get "/api/v1/customers/random.json"
    expect(response.status).to eq(200)
  end

  it "returns all invoices associated with a customer" do
    m = Merchant.create(name: "merchant")
    Customer.create(first_name: "adrienne", last_name: "domingus")
    c2 = Customer.create(first_name: "justin", last_name: "domingus")
    c3 = Customer.create(first_name: "name", last_name: "last name")
    c3.invoices.create(merchant_id: m.id, status: "success")
    c3.invoices.create(merchant_id: m.id, status: "success")
    c2.invoices.create(merchant_id: m.id, status: "success")

    get "/api/v1/customers/#{c3.id}/invoices"
    result = JSON.parse(response.body)
    expect(result.count).to eq(2)
  end
end
