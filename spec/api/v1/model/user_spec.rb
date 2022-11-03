require 'rails_helper'

RSpec.describe 'User model API', type: :model do
    let(:user_attributes) { 
        {
            email: Faker::Internet.email,
            password: "123456",
            password_confirmation: "123456"
        }
    }
    context "User be valid:" do
        it "all attributes are OK" do
            response = User.new(user_attributes)
            expect(response).to be_valid
        end
    end

    context "User be not valid:" do
        it "blank email" do
            response = User.new(
                email: nil,
                password: "123456",
                password_confirmation: "123456"
            )
            expect(response).to_not be_valid
        end
        it "wrong password confirmation" do
            response = User.new( 
                email: Faker::Internet.email,
                password: "123456",
                password_confirmation: "12356"
             )
            expect(response).to_not be_valid
        end
        it "user alread registred" do
            User.create!( user_attributes )
            response = User.new( user_attributes )
            expect(response).to_not be_valid
        end
        it "invalid email" do
            response = User.new( 
                email: 'abc,def@',
                password: "123456",
                password_confirmation: "12356"
             )
            expect(response).to_not be_valid
        end
    end
end