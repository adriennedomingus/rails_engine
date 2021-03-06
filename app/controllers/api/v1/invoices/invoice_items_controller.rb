module Api
  module V1
    class Invoices::InvoiceItemsController < ApplicationController
      respond_to :json

      def index
        respond_with Invoice.find(params[:id]).invoice_items
      end
    end
  end
end
