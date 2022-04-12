# frozen_string_literal: true

RSpec.describe Projects::SortingAndFilteringQuery do
  before { create_list(:project, 20) }

  let(:projects) { Project.all }
  let(:sorted_projects) { described_class.new(nil, order, projects: projects).call }

  describe '#call' do
    context 'when newest first' do
      let(:order) { 'newest' }

      it 'returns newest book first' do
        expect(sorted_projects[1..].pluck(:created_at)).to all(be < sorted_projects.first.created_at)
      end

      it 'changes books orde' do
        expect(sorted_projects).not_to eq(projects)
      end
    end

    context 'when low price first' do
      let(:order) { 'price_asc' }

      it 'returns cheapest book first' do
        expect(sorted_projects[1..].pluck(:price)).to all(be > sorted_projects.first.price)
      end

      it 'changes projects order' do
        expect(sorted_projects).not_to eq(projects)
      end
    end

    context 'when high price first' do
      let(:order) { 'price_desc' }

      it 'returns cheapest book first' do
        expect(sorted_projects[1..].pluck(:price)).to all(be < sorted_projects.first.price)
      end

      it 'changes projects order' do
        expect(sorted_projects).not_to eq(projects)
      end
    end

    context 'when order not set' do
      let(:order) { FFaker::Lorem.word }

      it 'not changes projects order' do
        expect(sorted_projects).to eq(projects)
      end
    end
  end
end
