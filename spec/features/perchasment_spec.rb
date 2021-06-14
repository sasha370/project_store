# frozen_string_literal: true

RSpec.describe 'Perchasment', type: :feature do
  describe 'Authorized User  ' do
    context 'with Catalog page' do
      context 'when press Add_to_cart ', js: true do
        let!(:project) { create(:project) }
        let!(:user) { create(:user) }

        it 'do it with success' do
          sign_in user
          visit(projects_path)
          page.find("#add_to_cart_#{project.id}", visible: :all).click
          expect(page).to have_content 'Project was succesfully add to cart'
        end
      end

      context 'when project already was added to cart', js: true do
        let(:project) { create(:project) }
        let(:user) { create(:user) }
        let!(:purchasment) { create(:purchasment, user: user, project: project) }

        it 'he can`t see Add_to_cart link' do
          sign_in user
          visit(projects_path)
          expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
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

    context 'with Project page ' do
      context 'when press Add_to_cart', js: true do
        let!(:project) { create(:project) }
        let!(:user) { create(:user) }

        it 'he do it with success' do
          sign_in user
          visit(project_path(project))
          page.find("#add_to_cart_#{project.id}", visible: :all).click
          expect(page).to have_content 'Project was succesfully add to cart'
        end
      end

      context 'when project was allready added to cart', js: true do
        let(:project) { create(:project) }
        let(:user) { create(:user) }
        let!(:purchasment) { create(:purchasment, user: user, project: project) }

        it 'he can`t see Add_to_cart link' do
          sign_in user
          visit(project_path(project))
          expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
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
      let(:project) { create(:project) }
      let(:user) { create(:user) }
      let!(:purchasment) { create(:purchasment, user: user, project: project) }

      it 'he can remove any purchase from cart' do
        sign_in user
        visit(cart_path)
        page.find("#remove_purchasment_#{purchasment.id}").click
        expect(page).to have_no_content(project.title)
      end
    end
  end

  describe 'NOT Authorized User' do
    context 'when he try to add to cart in Catalog page', js: true do
      let!(:purchasment) { create(:purchasment) }

      it 'he can`t see Add_to_cart link' do
        visit(projects_path(purchasment.project))
        expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
      end
    end

    context 'when he try to add to cart in Project page', js: true do
      let!(:purchasment) { create(:purchasment) }

      it 'he can`t see Add_to_cart link' do
        visit(project_path(purchasment.project))
        expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
      end
    end
  end
end
