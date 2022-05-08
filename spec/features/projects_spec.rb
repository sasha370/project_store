# frozen_string_literal: true

RSpec.describe 'Project', type: :feature do
  describe 'User can visit Catalog pages.
            To see projects by categories,
            I`d must be able to select it in catalog' do
    context 'when goes directly to Catalog' do
      it 'success' do
        visit(projects_path)
        expect(page).to have_content t('projects.index.page_title')
      end
    end

    context 'when looking only category`s projects' do
      let(:category1) { create(:category, title: 'First category') }
      let(:category2) { create(:category, title: 'Second category') }
      let!(:project1) { create(:project, category: category1) }
      let!(:project2) { create(:project, category: category2) }

      it 'includes First Category`s projects' do
        visit(projects_path(category_id: category1.id))
        expect(page).to have_content project1.decorate.title
        expect(page).not_to have_content project2.decorate.title
      end

      it 'includes All Category`s projects' do
        visit(projects_path)
        expect(page).to have_content project1.decorate.title
        expect(page).to have_content project2.decorate.title
      end
    end
  end
end
