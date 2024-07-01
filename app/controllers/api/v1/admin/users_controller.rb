module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :authenticate_admin!

        def destroy
          user = User.find(params[:id])
          if user.destroy
            render json: { message: 'User deleted' }, status: :ok
          else
            render json: { error: 'Could not complete request' }, status: :unprocessable_entity
          end
        end

        def suspend
          user = User.find(params[:id])
          user.toggle!(:status)
          render json: { message: 'User status updated', status: user.status }, status: :ok
        end

        private

        def authenticate_admin!
          render json: { error: 'Not authorized' }, status: :unauthorized unless current_user.admin?
        end

        def user_active!
          render json: { error: 'Not active' }, status: :forbidden unless current_user.active?
        end

        def set_user
          @user = User.find(params[:user_id])
        end
      end
    end
  end
end
