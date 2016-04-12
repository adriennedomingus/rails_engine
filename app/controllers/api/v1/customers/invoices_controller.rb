module Api
  module V1
    class Customers::InvoicesController < ApplicationController
      respond_to :json

      def index
        respond_with Customer.find(params[:id]).invoices
      end
    end
  end
end
