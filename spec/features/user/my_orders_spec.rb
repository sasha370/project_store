# frozen_string_literal: true

RSpec.describe 'MyOrders', type: :feature do
  let!(:user) { create(:user) }

  describe 'User can visit MyOrders page.' do
    it 'with success' do
      sign_in user
      visit(my_orders_path)
      expect(page).to have_content 'My Orders'
    end
  end

  describe 'User' do
    context 'when visit MyOrders page' do
      let!(:orders) { create_list(:order, 3, :with_items_and_archive, user: user, status: 'paid') }
      let!(:cart) { create(:order, :with_items_and_archive, user: user, status: 'cart') }

      before do
        sign_in user
        visit(my_orders_path)
      end

      it 'see paid Orders' do
        orders.each do |order|
          expect(page).to have_css("#paid_order_#{order.id}")
          order.projects.each do |project|
            expect(page).to have_css("#paid_project_#{project.id}")
            expect(page).to have_css("#download_project_#{project.id}")
          end
        end
      end

      it "don't see cart" do
        expect(page).not_to have_css("#paid_order_#{cart.id}")
      end
    end
  end

  describe "When some of project doesn't have attached archive" do
    let!(:order) { create(:order, :with_items, user: user, status: 'paid') }

    before do
      sign_in user
      visit(my_orders_path)
    end

    it 'user see button with info that file not found' do
      expect(page).to have_css("#paid_order_#{order.id}")
      order.projects.each do |project|
        expect(page).to have_css("#file_not_found_#{project.id}")
      end
    end
  end
end
