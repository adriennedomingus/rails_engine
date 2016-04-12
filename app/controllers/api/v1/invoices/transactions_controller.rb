module Api
  module V1
    class Invoices::TransactionsController < ApplicationController
      respond_to :json

      def index
        respond_with Invoice.find(params[:id]).transactions
      end
    end
  end
end
