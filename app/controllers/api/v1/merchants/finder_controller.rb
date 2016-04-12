module Api
  module V1
    class Merchants::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:name]
          respond_with Merchant.find_by("lower(name) = ?", params[:name].downcase)
        else
          respond_with Merchant.find_by(param.to_sym => params[param])
        end
      end

      def index
        if params[:name]
          respond_with Merchant.where("lower(name) = ?", params[:name].downcase)
        else
          respond_with Merchant.where(param.to_sym => params[param])
        end
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
