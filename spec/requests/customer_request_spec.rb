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
end
