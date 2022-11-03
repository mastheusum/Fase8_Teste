require 'rails_helper'

RSpec.describe 'User request API', type: :request do
    let(:headers) { 
        { "Accept" => "application/json", "Authorization" => user.auth_token }
    }
    let!(:user_attributes) {
        {
            email: Faker::Internet.email,
            password: "abcdef",
            password_confirmation: "abcdef"
        }
    }
    let!(:user) { 
        User.create( 
            email: Faker::Internet.email,
            password: "123456",
            password_confirmation: "123456"
        )
    }
    let(:user_id) { user.id }
        
        before { host! "localhost:3000/api" }
        
    describe "GET/" do
        context "valid requests to" do
            it "[index]" do
                get "/users", params: {}, headers: headers
                expect(response).to have_http_status(200)
            end
            it "[show] show user" do
                get "/users/#{user_id}", params: {}, headers: headers
                expect(response).to have_http_status(200)
            end
        end
        
        context "invalid requests to" do
            it "[show] user not found" do
                get "/users/#{100000000}", params: {}, headers: headers
                expect(response).to have_http_status(404)
            end
        end
    end
    describe "POST/" do
        context "valid requests to" do
            it "[create] create new user" do
                post "/users", params: { user: user_attributes }
                expect(response).to have_http_status(201)
            end
        end
        context "invalid request to" do
            it "[create] user alread registred" do
                post "/users", params: { user: {
                    email: user.email,
                    password: 'abcdef',
                    password_confirmation: 'abcdef'
                } }, headers: headers
                expect(json_body).to have_key('errors')
            end
            it "[create] invalid e-mail" do
                post "/users", params: { user: {
                    email: 'user,email@',
                    password: 'abcdef',
                    password_confirmation: 'abcdef'
                } }, headers: headers
                expect(json_body).to have_key('errors')
            end
            it "[create] password confirmation doesn't match" do
                post "/users", params: { user: {
                    email: Faker::Internet.email,
                    password: 'abcdef',
                    password_confirmation: '123456'
                } }, headers: headers
                expect(json_body).to have_key('errors')
            end
        end
    end
    describe "PUT/" do
        context "valid requests to" do
            let(:user_param) { { email: Faker::Internet.email } }
            before do
                put "/users/#{user_id}", params: { user: user_param }, headers: headers
            end
            it "[update] update a user" do
                expect(response).to have_http_status(200)
            end
            it "[update] return new data for updated user" do
                expect(json_body['email']).to eq(user_param[:email]) 
            end
        end
        context "invalid request to" do
            let(:user_param) { { email: 'user,email@' } }
            before do
                put "/users/#{user_id}", params: { user: user_param }, headers: headers
            end
            it "[update] invalid email" do
                expect(response).to have_http_status(422)
            end
            it "[update] found errors" do
                expect(json_body).to have_key('errors')
            end
        end
    end
    describe "DELETE/" do
        context "valid requests to" do
            before do
                delete "/users/#{user_id}", params: {}, headers: headers
            end
            it "[destroy] return status code 204" do
                expect(response).to have_http_status(204)
            end
            it "[destroy] removes the user from database" do
                expect(User.find_by(id: user.id)).to be_nil
            end
        end
    end
end