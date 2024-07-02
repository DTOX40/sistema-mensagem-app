module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :authenticate_admin!
      before_action :user_active!
      before_action :set_user, only: [:update, :suspend, :destroy]

      def index
        @users = Rails.cache.fetch('users', expires_in: 10.minutes) do
          User.all.to_a
        end
        render json: @users, status: :ok
      end

      def update
        if @user.update(user_params)
          render json: @user, status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def suspend
        new_status = @user.active? ? 'Inactive' : 'Active'
        if @user.update(status: new_status)
          render json: { message: "User status updated to: #{@user.status}" }, status: :ok
        else
          render json: { error: "Could not update user status" }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: "User not found: #{e.message}" }, status: :not_found
      end

      def search
        results = search_params[:keyword].present? ? User.search_users(search_params[:keyword]) : User.all
        direction = search_params[:direction] == 'desc' ? 'desc' : ''
        results = results.order("#{search_params[:sort].join(',')} #{direction}") if search_params[:sort].present? && search_params[:sort].any?
        render json: results, status: :ok
      end

      def destroy
        if @user.destroy
          render json: { message: 'User deleted successfully' }, status: :ok
        else
          render json: { error: 'Could not delete user' }, status: :unprocessable_entity
        end
      end

      private

      def search_params
        params.permit(:keyword, :direction, sort: [])
      end

      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: "User not found: #{e.message}" }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:name, :email)
      end

      def authorize_admin!
        render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.admin?
      end
    end
  end
end
