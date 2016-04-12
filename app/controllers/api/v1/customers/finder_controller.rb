module Api
  module V1
    class Customers::FinderController < ApplicationController
      respond_to :json

      def show
        if params[:id]
          respond_with Customer.find(params[:id])
        elsif params[:first_name]
          respond_with Customer.find_by("lower(first_name) = ?", params[:first_name].downcase)
        elsif params[:last_name]
          respond_with Customer.find_by("lower(last_name) = ?", params[:last_name].downcase)
        elsif params[:created_at]
          respond_with Customer.find_by(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Customer.find_by(created_at: params[:updated_at])
        end
      end

      def index
        if params[:id]
          respond_with Customer.where(id: params[:id])
        elsif params[:first_name]
          respond_with Customer.where("lower(first_name) = ?", params[:first_name].downcase)
        elsif params[:last_name]
          respond_with Customer.where("lower(last_name) = ?", params[:last_name].downcase)
        elsif params[:created_at]
          respond_with Customer.where(created_at: params[:created_at])
        elsif params[:updated_at]
          respond_with Customer.where(created_at: params[:updated_at])
        end
      end
    end
  end
end
