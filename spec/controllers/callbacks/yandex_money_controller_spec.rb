# frozen_string_literal: true

RSpec.describe Callbacks::YandexMoneyController, type: :controller do
  describe 'POST #perform' do
    let(:perform) { post :perform, params: json }
    let!(:payment) { create :payment }
    let(:json) do
      { operation_id: '1234567',
        notification_type: 'p2p-incoming',
        datetime: '2011-07-01T09:00:00.000+04:00',
        sha1_hash: 'dd16d10d49d810ced60388aa8807f20b769ed477',
        sender: '41001XXXXXXXX',
        codepro: false,
        currency: 643,
        amount: 300.00,
        withdraw_amount: 1.00,
        label: payment.id.to_s }
    end

    context 'when authorized' do
      it 'return 200 status' do
        perform
        expect(response).to have_http_status :ok
      end
    end

    # TODO
    # check for 401  && not update payload
    # check that order & payload updated
  end
end
