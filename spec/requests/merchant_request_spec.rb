require 'rails_helper'

RSpec.describe "Merchant endpoint" do
  it "returns a hash of all merchants" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")
    m3 = Merchant.create(name: "merchant 3")
    Merchant.create(name: "merchant 4")

    get "/api/v1/merchants.json"
    result = JSON.parse(response.body)

    expect(result.count).to eq(4)
    expect(result.first["name"]).to eq(m1.name)
    expect(result[2]["id"]).to eq(m3.id)
  end

  it "returns a specific merchant" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")

    get "/api/v1/merchants/#{m1.id}.json"
    result = JSON.parse(response.body)

    expect(result["name"]).to eq(m1.name)
  end

  it "returns a random merchant" do
    m1 = Merchant.create(name: "merchant 1")
    Merchant.create(name: "merchant 2")

    get "/api/v1/merchants/random.json"
    expect(response.status).to eq(200)
  end
end
