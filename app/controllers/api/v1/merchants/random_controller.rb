module Api
  module V1
    class Merchants::RandomController < ApplicationController
      respond_to :json

      def show
        offset = rand(Merchant.count)
        respond_with Merchant.offset(offset).first
      end
    end
  end
end
