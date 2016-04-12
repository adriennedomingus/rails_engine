module Api
  module V1
    class InvoiceItems::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with InvoiceItem.find(params[:id])
        elsif params[:item_id]
          respond_with InvoiceItem.find_by(item_id: params[:item_id])
        elsif params[:invoice_id]
          respond_with InvoiceItem.find_by(invoice_id: params[:invoice_id])
        elsif params[:quantity]
          respond_with InvoiceItem.find_by(quantity: params[:quantity])
        elsif params[:unit_price]
          respond_with InvoiceItem.find_by(unit_price: params[:unit_price])
        elsif params[:created_at]
          respond_with InvoiceItem.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with InvoiceItem.find_by(created_at: params[:updated_at])
        end
      end

      def index
        if params[:id]
          respond_with InvoiceItem.where(id: params[:id])
        elsif params[:item_id]
          respond_with InvoiceItem.where(item_id: params[:item_id])
        elsif params[:invoice_id]
          respond_with InvoiceItem.where(invoice_id: params[:invoice_id])
        elsif params[:quantity]
          respond_with InvoiceItem.where(quantity: params[:quantity])
        elsif params[:unit_price]
          respond_with InvoiceItem.where(unit_price: params[:unit_price])
        elsif params[:created_at]
          respond_with InvoiceItem.where(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with InvoiceItem.where(created_at: params[:updated_at])
        end
      end
    end
  end
end
