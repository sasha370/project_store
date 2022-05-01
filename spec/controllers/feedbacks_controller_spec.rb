# frozen_string_literal: true

RSpec.describe FeedbacksController, type: :controller do
  let(:user) { create(:user) }

  describe '#new' do
    before do
      login(user)
    end

    context 'when success' do
      before { get :new }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns @feedback' do
        get :new
        expect(assigns(:feedback)).to an_instance_of(Feedback)
      end
    end
  end

  describe '#create' do
    before do
      login(user)
    end

    context 'when success' do
      let(:params) { { feedback: { title: 'Some title', body: 'Some body', user_id: user.id } } }

      it 'returns 302 status' do
        post :create, params: params
        expect(response).to have_http_status(:redirect)
      end

      it 'creates feedback' do
        expect { post :create, params: params }.to change(Feedback, :count).by(1)
      end

      it 'notify user' do
        expect { post :create, params: params }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'creates feedback with correct data' do
        post :create, params: params
        expect(Feedback.last).to have_attributes(title: params[:feedback][:title],
                                                 body: params[:feedback][:body],
                                                 user_id: params[:feedback][:user_id])
      end
    end
  end

  describe '#create with failure' do
    before do
      login(user)
    end

    context 'when success' do
      let(:params) { { feedback: { title: 'Some title', body: 'Some body', user_id: nil } } }

      it 'render New' do
        post :create, params: params
        expect(response).to render_template :new
      end

      it 'creates feedback' do
        expect { post :create, params: params }.not_to change(Feedback, :count)
      end

      it 'notify user' do
        expect { post :create, params: params }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end

  describe 'not Authorized users' do
    it 'redirect to log in' do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end
end
