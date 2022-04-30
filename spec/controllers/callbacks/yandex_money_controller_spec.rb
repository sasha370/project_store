# frozen_string_literal: true

RSpec.describe Callbacks::YandexMoneyController, type: :controller do
  subject(:perform) { post :perform, params: json }

  let(:amount) { 300.99 }
  let(:order) { create :order, amount: amount, status: 0 }
  let(:json) do
    {
      operation_id: '1234567',
      notification_type: 'p2p-incoming',
      datetime: '2011-07-01T09:00:00.000+04:00',
      sha1_hash: 'f47d3fc727bdfd1fa1815b85426ce0041c54aeca',
      sender: '41001XXXXXXXX',
      codepro: false,
      currency: 643,
      amount: amount, # in real responce amount will be with tax
      withdraw_amount: amount,
      label: '1'
    }
  end
  let!(:payment) { create :payment, order: order }

  describe 'POST #perform' do
    context 'when authorized' do
      it 'return 200 status' do
        perform
        expect(response).to have_http_status :ok
      end
    end

    context 'when Unauthorized' do
      before { json.merge!(sha1_hash: 'wrong_hash') }

      it 'return 401 status' do
        perform
        expect(response).to have_http_status :unauthorized
      end

      it 'do not trigger OrderMailer' do
        expect { perform }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end

    context 'when incorrect withdraw_amount' do
      before do
        # sha1 in callback_payload depends of Payment.id
        allow(Payment).to receive(:find_by).and_return(payment)
        json.merge!(withdraw_amount: 100)
      end

      it 'return 400 status' do
        perform
        expect(response).to have_http_status :bad_request
      end

      it 'do not trigger OrderMailer' do
        expect { perform }.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end

  describe 'data consistency' do
    context 'when payload is correct' do
      before do
        # sha1 in callback_payload depends of Payment.id
        allow(Payment).to receive(:find_by).and_return(payment)
      end

      it 'updates payment' do
        perform
        expect(payment).to be_paid
        expect(payment.order).to be_paid
      end

      it 'send confirmation email' do
        expect { perform }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end
  end
end
