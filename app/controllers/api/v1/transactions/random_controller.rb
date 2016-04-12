module Api
  module V1
    class Transactions::RandomController < ApplicationController
      respond_to :json

      def show
        offset = rand(Transaction.count)
        respond_with Transaction.offset(offset).first
      end
    end
  end
end
