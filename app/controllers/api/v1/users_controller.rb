class Api::V1::UsersController < ApplicationController

    def index
        render json: {}, status: 200
    end

    def show
        begin
            user = User.find(params[:id])
            render json: user, status: 200
        rescue
            render json: { }, status: 404
        end
    end

    def create
        user = User.new(user_params)

        if user.save
            render json: user, status: 201
        else
            render json: { errors: user.errors }, status: 422
        end
    end

    def update
        begin
            user = User.find(params[:id])
            if user.update(user_params)
                render json: user, status: 200
            else
                render json: { errors: user.errors }, status: 422
            end
        rescue
            render json: { }, status: 404
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: {}, status: 204
    end

    private
        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation)
        end
end
