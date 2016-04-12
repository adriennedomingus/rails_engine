module Api
  module V1
    class Invoices::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with Invoice.find(params[:id])
        elsif params[:item_id]
          respond_with Invoice.find_by(item_id: params[:item_id])
        elsif params[:customer_id]
          respond_with Invoice.find_by(customer_id: params[:customer_id])
        elsif params[:merchant_id]
          respond_with Invoice.find_by(merchant_id: params[:merchant_id])
        elsif params[:status]
          respond_with Invoice.find_by(status: params[:status])
        elsif params[:created_at]
          respond_with Invoice.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Invoice.find_by(created_at: params[:updated_at])
        end
      end

      def index
        if params[:id]
          respond_with Invoice.where(id: params[:id])
        elsif params[:item_id]
          respond_with Invoice.where(item_id: params[:item_id])
        elsif params[:customer_id]
          respond_with Invoice.where(customer_id: params[:customer_id])
        elsif params[:merchant_id]
          respond_with Invoice.where(merchant_id: params[:merchant_id])
        elsif params[:status]
          respond_with Invoice.where(status: params[:status])
        elsif params[:created_at]
          respond_with Invoice.where(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Invoice.where(created_at: params[:updated_at])
        end
      end
    end
  end
end
