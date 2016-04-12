module Api
  module V1
    class Items::MerchantsController < ApplicationController
      respond_to :json

      def show
        respond_with Item.find(params[:id]).merchant
      end
    end
  end
end
