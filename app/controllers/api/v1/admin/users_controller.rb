module Api
  module V1
    module Admin
      class UsersController < ApplicationController
        before_action :authenticate_user!
        before_action :authenticate_admin!
        before_action :user_active!
        before_action :set_user, only: [:suspend]

        def suspend
          status = User.statuses['Suspended']
          status = User.statuses['Active'] if @user.status == 'Suspended'
          if @user.update(status: status)
            render json: { message: 'Updated user status', status: @user.status }, status: :ok
          else
            render json: { error: 'Could not complete request' }, status: :unprocessable_entity
          end
        end

        def destroy
          user = User.find(params[:id])
          if user.destroy
            render json: { message: 'User deleted' }, status: :ok
          else
            render json: { error: 'Could not complete request' }, status: :unprocessable_entity
          end
        end

        private

        def set_user
          @user = User.find(params[:id])
        end
    
        def user_params
          params.permit(:user_id, :id)
        end
      end
    end
  end
end
