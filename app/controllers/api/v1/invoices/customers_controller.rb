module Api
  module V1
    class Invoices::CustomersController < ApplicationController
      respond_to :json

      def index
        respond_with Invoice.find(params[:id]).customer
      end
    end
  end
end
