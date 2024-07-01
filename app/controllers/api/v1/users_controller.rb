module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :user_active!

      def index
        users = User.all
        render json: users, status: :ok
      end

      def search
      end

      private

      def user_active!
        render json: { error: 'Not active' }, status: :forbidden unless current_user.active?
      end
    end
  end
end
