module Api
  module V1
    class Transactions::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with Transaction.find(params[:id])
        elsif params[:invoice_id]
          respond_with Transaction.find_by(invoice_id: params[:invoice_id])
        elsif params[:credit_card_number]
          respond_with Transaction.find_by(credit_card_number: params[:credit_card_number])
        elsif params[:result]
          respond_with Transaction.find_by(result: params[:result])
        elsif params[:created_at]
          respond_with Transaction.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Transaction.find_by(created_at: params[:updated_at])
        end
      end

      def index
        if params[:id]
          respond_with Transaction.where(id: params[:id])
        elsif params[:invoice_id]
          respond_with Transaction.where(invoice_id: params[:invoice_id])
        elsif params[:credit_card_number]
          respond_with Transaction.where(credit_card_number: params[:credit_card_number])
        elsif params[:result]
          respond_with Transaction.where(result: params[:result])
        elsif params[:created_at]
          respond_with Transaction.where(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Transaction.where(created_at: params[:updated_at])
        end
      end
    end
  end
end
