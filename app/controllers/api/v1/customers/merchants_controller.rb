module Api
  module V1
    class Customers::MerchantsController < ApplicationController
      respond_to :json

      def show
        respond_with Customer.find(params[:id]).favorite_merchant
      end
    end
  end
end
