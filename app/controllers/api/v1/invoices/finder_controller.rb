module Api
  module V1
    class Invoices::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:status]
          respond_with Invoice.find_by("lower(status) = ?", params[:status].downcase)
        else
          respond_with Invoice.find_by(param.to_sym => params[param])
        end
      end

      def index
        if params[:status]
          respond_with Invoice.where("lower(status) = ?", params[:status].downcase)
        else
          respond_with Invoice.where(param.to_sym => params[param])
        end
      end

      private
        def param
          params.keys.first
        end
    end
  end
end
