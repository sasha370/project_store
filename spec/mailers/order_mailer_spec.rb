# frozen_string_literal: true

RSpec.describe OrderMailer, type: :mailer do
  let(:order) { create :order, :with_items }
  let(:mail) { described_class.with(id: order.id).new_order.deliver_now }

  describe 'after payment confirmed' do
    it 'renders the subject' do
      expect(mail.subject).to eq("Заказ #{order.id} на сайте Diy-plans.ru")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([order.user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@diy-plans.ru'])
    end

    it 'update order notification_sent_at' do
      described_class.with(id: order.id).new_order.deliver_now
      order.reload

      expect(order.notification_sent_at).not_to be_nil
    end
  end

  describe "when Order doesn't exist" do
    let(:mail) { described_class.with(id: 0).new_order.deliver_now }

    it 'do nothing' do
      expect(mail).to be_nil
    end
  end
end
