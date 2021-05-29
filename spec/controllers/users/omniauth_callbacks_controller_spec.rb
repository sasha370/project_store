require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  shared_examples_for 'providers' do |provider|
    describe '#{provider} test' do
      let(:oauth_data) do
        {
          'provider' => provider,
          'uid' => '123545',
          'info' => {
            'email' => 'test@test.ru',
            'first_name' => 'mock_name'
          }
        }
      end

      let(:oauth_data_without_email) do
        {
          'provider' => provider,
          'uid' => '123545'
        }
      end

      let(:broken_oauth_data) do
        {
          'providere' => provider,
          'uid2' => '123545'
        }
      end

      context 'when user exist' do
        let!(:user) { create(:user, email: 'test@test.ru', first_name: 'mock_name') }

        before do
          allow(request.env).to receive(:[]).and_call_original
          allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
          get provider.to_sym
        end

        it 'login user if it exist' do
          expect(subject.current_user).to eq user
        end

        it 'redirect to root path' do
          expect(response).to redirect_to root_path
        end
      end

      context 'user does not exist' do
        before do
          allow(request.env).to receive(:[]).and_call_original
          allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
          get provider.to_sym
        end

        it 'redirect to root path if user does not exist' do
          expect(response).to redirect_to root_path
        end
      end

      context 'user does not exist and responce don`t have Email' do
        before do
          allow(request.env).to receive(:[]).and_call_original
          allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data_without_email)
          get provider.to_sym
        end

        it 'redirect to registration_path' do
          expect(response).to redirect_to new_user_registration_url
        end
      end

      context 'when broken oauth data' do
        before do
          allow(request.env).to receive(:[]).and_call_original
          allow(request.env).to receive(:[]).with('omniauth.auth').and_return(invalid_mock(provider))
          get provider.to_sym
        end

        it 'redirect to root path' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  # describe 'Github' do
  #   it_behaves_like 'providers', 'github'
  # end
  describe 'Facebook' do
    it_behaves_like 'providers', 'facebook'
  end

  # describe 'GoogleAuth' do
  #   it_behaves_like 'providers', 'google_oauth2'
  # end

  # describe 'VKontakte' do
  #   it_behaves_like 'providers', 'vkontakte'
  # end
end
