# frozen_string_literal: true

RSpec.describe 'Cart', type: :feature do
  include ActionView::Helpers::NumberHelper

  describe 'when Auth user checkout' do
    let(:user) { create(:user) }
    let!(:cart) { create(:order, :with_items_and_archive, user: user) }

    before do
      sign_in user
      visit(cart_path)
    end

    context 'fields is all correct' do
      it do
        expect(page.find("p#total_amount", visible: :all).text).to eq(number_to_currency(cart.amount))
        expect(page.find("p#total_discount", visible: :all).text).to eq(number_to_currency(cart.discount))
        expect(page.find("#amount_with_discount", visible: :all).text).to eq(number_to_currency(cart.amount_with_discount))
      end
    end

    context 'when one item was removed', js: true do
      it 'recalculate total amount for YM form' do
        old_amount = cart.amount
        amount_with_discount = cart.amount_with_discount
        project_to_remove = cart.projects.last
        page.find("#remove_order_project_#{project_to_remove.id}", visible: :all).click
        expected_new_amount = old_amount - project_to_remove.price
        expected_new_amount_with_discount = amount_with_discount - project_to_remove.price
        sleep 0.5
        # expect(page.find("p#total_amount", visible: :all).text).to eq(number_to_currency(expected_new_amount))
        # expect(page.find("p#amount_with_discount", visible: :all).text).to eq(number_to_currency(expected_new_amount_with_discount))
        expect(page.find("#checkout_sum", visible: :all).value.to_f).to eq(expected_new_amount_with_discount)
      end
    end
  end

  describe 'when Guest user logged in' do
    let(:user) { create(:user) }
    let(:project) { create :project }

    context 'then guest cart is addicting to current user', js: true do
      it do
        visit(project_path(project))
        page.find("#add_to_cart_#{project.id}", visible: :all).click
        expect(page).to have_content I18n.t('orders.success')

        sign_in user
        expect(user.cart.projects).to include(project)
      end
    end
  end

  describe 'when not Auth user makes checkout', js: true do
    let(:user) { create(:user) }
    let(:project) { create :project }

    context 'it must see ask_email field' do
      it do
        visit project_path(project)
        page.find("#add_to_cart_#{project.id}", visible: :all).click
        visit cart_path
        expect(page).to have_selector(:id, 'ask_email_submit')
      end
    end

    context 'it must show payment button after inputs email' do
      it do
        visit project_path(project)
        page.find("#add_to_cart_#{project.id}", visible: :all).click
        visit cart_path
        fill_in 'email', with: 'my_new_email@email.com'
        page.find("#ask_email_submit", visible: :all).click

        expect(page).to have_selector(:id, 'payment_button')
      end
    end
  end
end
