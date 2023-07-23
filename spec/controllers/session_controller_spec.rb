require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#create' do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'with valid credentials' do
      it 'should set the user_id in the session' do
        post :create, params: { email: user.email, password: 'password123' }
        expect(session[:user_id]).to eq(user.id)
      end

      it 'should redirect to root_path with a success notice' do
        post :create, params: { email: user.email, password: 'password123' }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Logged in successfully.')
      end
    end

    context 'with invalid credentials' do
      it 'should not set the user_id in the session' do
        post :create, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(session[:user_id]).to be_nil
      end

      it 'should set an error message in flash.now' do
        post :create, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(flash.now[:alert]).to eq('Invalid email or password.')
      end

      it 'should render the new template' do
        post :create, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    it 'should clear the user_id from the session' do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end

    it 'should redirect to root_path with a success notice' do
      delete :destroy
      expect(response).to redirect_to(root_path)
      expect(flash
