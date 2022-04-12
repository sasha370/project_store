# frozen_string_literal: true

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    context 'when success' do
      before { get :index }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders show template' do
        expect(response).to render_template(:index)
      end
    end

    context 'with projects' do
      let(:category1) { create(:category) }
      let(:category2) { create(:category) }
      let!(:projects1) { create_list(:project, 2, category: category1) }
      let!(:projects2) { create_list(:project, 3, category: category2) }

      before do
        # Seed unpublished project to DB
        create_list(:project, 3, category: category2, status: :newest)
      end

      it 'assigns the requested projects to ALL published @projects' do
        get :index
        expect(assigns(:projects).count).to eq (projects1 + projects2).count
      end

      it 'assigns the requested projects to Category`s @projects' do
        get :index, params: { category_id: category2.id }
        expect(assigns(:projects).count).to eq(projects2.count)
      end
    end

    context 'with out projects' do
      it 'assigns the requested projects empty' do
        get :index
        expect(assigns(:projects)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    let(:project) { create(:project) }

    before { get :show, params: { id: project } }

    it 'assigns the requested project to @project' do
      expect(assigns(:project)).to eq(project)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
