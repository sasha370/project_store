# frozen_string_literal: true

RSpec.describe Projects::SortingAndFilteringQuery do
  before { create_list(:project, 20) }

  let(:projects) { Project.all }
  let(:sorted_projects) { described_class.new(nil, order, projects: projects).call }

  describe '#call' do
    context 'when sorting not set (default)' do
      let(:order) { nil }

      it 'returns newest book first' do
        expect(sorted_projects[1..].pluck(:created_at)).to all(be < sorted_projects.first.created_at)
      end
    end

    context 'when newest first' do
      let(:order) { 'newest' }

      it 'returns newest book first' do
        expect(sorted_projects[1..].pluck(:created_at)).to all(be < sorted_projects.first.created_at)
      end
    end

    context 'when oldest first' do
      let(:order) { 'oldest' }

      it 'returns oldest book first' do
        expect(sorted_projects[1..].pluck(:created_at)).to all(be > sorted_projects.first.created_at)
      end
    end

    context 'when low price first' do
      let(:order) { 'price_asc' }

      it 'returns cheapest book first' do
        expect(sorted_projects[1..].pluck(:price)).to all(be >= sorted_projects.first.price)
      end
    end

    context 'when high price first' do
      let(:order) { 'price_desc' }

      it 'returns cheapest book first' do
        expect(sorted_projects[1..].pluck(:price)).to all(be < sorted_projects.first.price)
      end
    end
  end
end
