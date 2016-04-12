module Api
  module V1
    class Transactions::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:result]
          respond_with Transaction.find_by("lower(result) = ?", params[:result].downcase)
        else
          respond_with Transaction.find_by(param.to_sym => params[param])
        end
      end

      def index
        if params[:result]
          respond_with Transaction.where("lower(result) = ?", params[:result].downcase)
        else
          respond_with Transaction.where(param.to_sym => params[param])
        end
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
