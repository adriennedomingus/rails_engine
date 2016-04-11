require 'rails_helper'

RSpec.describe "Merchant endpoint" do
  it "returns a hash of all merchants" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")
    m3 = Merchant.create(name: "merchant 3")
    Merchant.create(name: "merchant 2")

    get "/api/v1/merchants.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(4)
    expect(result.first["name"]).to eq(m1.name)
    expect(result[2]["id"]).to eq(m3.id)
  end
end
