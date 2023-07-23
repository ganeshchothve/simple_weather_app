require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#create' do
    context 'with valid user parameters' do
      it 'should create a new user' do
        user_params = { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } }
        expect {
          post :create, params: user_params
        }.to change(User, :count).by(1)
      end

      it 'should redirect to root_path with a success notice' do
        user_params = { user: { email: 'test@example.com', password: 'password123', password_confirmation: 'password123' } }
        post :create, params: user_params
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('User successfully registered.')
      end
    end

    context 'with invalid user parameters' do
      it 'should not create a new user' do
        user_params = { user: { email: 'invalid_email', password: 'password123', password_confirmation: 'password456' } }
        expect {
          post :create, params: user_params
        }.not_to change(User, :count)
      end

      it 'should render the new template' do
        user_params = { user: { email: 'invalid_email', password: 'password123', password_confirmation: 'password456' } }
        post :create, params: user_params
        expect(response).to render_template(:new)
      end
    end
  end
end
