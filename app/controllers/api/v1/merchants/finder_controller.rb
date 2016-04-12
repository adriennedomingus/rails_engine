module Api
  module V1
    class Merchants::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with Merchant.find(params[:id])
        elsif params[:name]
          respond_with Merchant.find_by(name: params[:name])
        elsif params[:created_at]
          respond_with Merchant.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Merchant.find_by(created_at: params[:updated_at])
        end
      end
    end
  end
end
