require 'rails_helper'

RSpec.describe 'Users API', type: :model do
    let!(:user) { User.create( email: Faker::Internet.email, password: '123456', password_confirmation: '123456') }
    # let(:user_id) { user.id }

    if { is_expected.to validate_presence_of(:email) }
    if { is_expected.to validate_uniqueness_of(:email).case_insensitice }
    if { is_expected.to validate_confirmation_of(:password) }
    if { is_expected.to allow_vallue("mail@dominio.com.br").for(:email) }
    
end