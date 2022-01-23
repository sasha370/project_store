# frozen_string_literal: true

RSpec.describe 'Order', type: :feature do
  describe 'Authorized User ' do
    context 'with Catalog page' do
      # TODO, turned off
      # context 'when press Add_to_cart ', js: true do
      #   let!(:project) { create(:project) }
      #   let!(:user) { create(:user) }
      #
      #   it 'do it with success' do
      #     sign_in user
      #     visit(projects_path)
      #     page.find("#add_to_cart_#{project.id}", visible: :all).click
      #     expect(page).to have_content 'Project was successfully add to cart'
      #   end
      # end

      context 'when project already was added to cart', js: true do
        let(:user) { create(:user) }
        let!(:order) { create(:order, :with_items, user: user) }
        let(:project) { order.projects.first }

        it 'he can`t see Add_to_cart link' do
          sign_in user
          visit(projects_path)
          expect(page).to have_no_link("#add_to_cart_#{project.id}")
        end

        it 'he can see link Go_to_cart' do
          sign_in user
          visit(projects_path)
          within(id: "project_card_#{project.id}") do
            expect(page).to have_link(href: '/cart', visible: :all)
          end
        end
      end
    end

    context 'with Project page' do
      context 'when press Add_to_cart', js: true do
        let!(:project) { create(:project) }
        let!(:user) { create(:user) }

        it 'he do it with success' do
          sign_in user
          visit(project_path(project))
          page.find("#add_to_cart_#{project.id}", visible: :all).click
          expect(page).to have_content 'Project was successfully add to cart'
          expect(page.find('#item_counter', visible: :all)).to have_content ''
        end
      end

      context 'when project was already added to cart', js: true do
        let(:user) { create(:user) }
        let!(:order) { create(:order, :with_items, user: user) }
        let(:project) { order.projects.first }

        it 'he can`t see Add_to_cart link' do
          sign_in user
          visit(project_path(project))
          expect(page).to have_no_link("#add_to_cart_#{project.id}")
        end

        it 'he can see link Go_to_cart' do
          sign_in user
          visit(project_path(project))
          within(id: "project_card_#{project.id}") do
            expect(page).to have_link(href: '/cart', visible: :all)
          end
        end
      end
    end

    context 'with  Cart page', js: true do
      let(:user) { create(:user) }
      let!(:order) { create(:order, :with_items, user: user) }
      let(:order_project) { order.order_projects.first }

      it 'he can remove any item from cart' do
        sign_in user
        visit(cart_path)
        page.find("#remove_order_project_#{order_project.id}").click
        expect(page).to have_no_content(order_project.project.title)
        expect(page.find('#item_counter', visible: :all)).to have_content order.projects.count.to_s
      end
    end
  end

  describe 'NOT Authorized User' do
    context 'when he try to add to cart in Catalog page', js: true do
      let!(:order) { create(:order, :with_items) }
      let(:project) { order.projects.first }

      it 'he can`t see Add_to_cart link' do
        visit(projects_path(project.id))
        expect(page).to have_no_link("#add_to_cart_#{project.id}")
      end

      it 'cart icon is invisible' do
        expect(page).to have_no_link('#item_counter')
      end
    end

    context 'when he try to add to cart in Project page', js: true do
      let!(:order) { create(:order, :with_items) }
      let(:project) { order.projects.first }

      it 'he can`t see Add_to_cart link' do
        visit(project_path(project.id))
        expect(page).to have_no_link("#add_to_cart_#{project.id}")
      end
    end
  end
end
