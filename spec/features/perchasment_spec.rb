# frozen_string_literal: true

RSpec.describe 'Perchasment', type: :feature do
  describe 'Authorized User  ' do
    context 'directly from Catalog' do
      context 'when put in cart ', js: true do
        let!(:project) { create(:project) }
        let!(:user) { create(:user) }

        it 'and do it with success' do
          sign_in user
          visit(projects_path)
          page.find("#add_to_cart_#{project.id}", visible: :all).click
          expect(page).to have_content 'Project was succesfully add to cart'
        end
      end

      context 'when allready both this project ', js: true do
        let(:project) { create(:project) }
        let(:user) { create(:user) }
        let!(:purchasment) { create(:purchasment, user: user, project: project) }

        it 'can`t see link' do
          sign_in user
          visit(projects_path)
          expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
        end
      end
    end

    context 'add from Project card' do
      context 'when put in cart', js: true do
        let!(:project) { create(:project) }
        let!(:user) { create(:user) }

        it 'and do it with success' do
          sign_in user
          visit(project_path(project))
          page.find("#add_to_cart_#{project.id}", visible: :all).click
          expect(page).to have_content 'Project was succesfully add to cart'
        end
      end

      context 'when allready both this project ', js: true do
        let(:project) { create(:project) }
        let(:user) { create(:user) }
        let!(:purchasment) { create(:purchasment, user: user, project: project) }

        it 'can`t see link' do
          sign_in user
          visit(project_path(project))
          expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
        end
      end
    end
  end

  describe 'NOT Authorized User' do
    context 'when try to add to cart in Catalog', js: true do
      let!(:purchasment) { create(:purchasment) }

      it 'can`t see link' do
        visit(projects_path(purchasment.project))
        expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
      end
    end

    context 'when try to add to cart in Project card', js: true do
      let!(:purchasment) { create(:purchasment) }

      it 'can`t see link' do
        visit(project_path(purchasment.project))
        expect(page).to have_no_link("#add_to_cart_#{purchasment.project.id}")
      end
    end
  end
end
