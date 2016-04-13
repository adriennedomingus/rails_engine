require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  it { should belong_to :item }
  it { should belong_to :invoice }
  it { should have_many :transactions }
end
