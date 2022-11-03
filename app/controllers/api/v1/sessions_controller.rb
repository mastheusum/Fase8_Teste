class Api::V1::SessionsController < ApplicationController
    def create
        user = User.find_by(email: sessions_params[:email])

        if user && user.valid_password?(sessions_params[:password])
            # store: false faz com que o devise não crie uma sessão
            sign_in user, store: false 
            user.generate_authentication_token!
            user.save
            render json: user, status: 200
        else
            render json: { errors: 'E-mail ou Senha inválidos' }, status: 401
        end
    end

    def destroy
        user = User.find_by(auth_token: params[:id])
        user.generate_authentication_token!
        user.save
        render json: {}, status: 204
    end

    private
        def sessions_params
            params.require(:session).permit(:email, :password)
        end
end
