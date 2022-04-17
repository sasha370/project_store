# frozen_string_literal: true

RSpec.describe Project, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :short_description }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :difficulty }
  it { is_expected.to validate_presence_of :status }
  it { is_expected.to validate_presence_of :price }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:buyers) }
  it { is_expected.to have_many(:orders).through(:order_projects) }
  it { is_expected.to have_many(:order_projects) }

  # TODO, test for main_image
  #
  describe 'when price for on project in cart was changed' do
    let!(:cart) { create :order, :with_items }

    it 'do not touch order' do
      allow(cart).to receive(:update_amount)
      project = cart.projects.first
      project.update(title: 'new_title')
      expect(cart).not_to have_received(:update_amount)
    end
  end
end
