# frozen_string_literal: true

RSpec.describe ApplicationController, type: :controller do
  describe '#authenticate_admin_user!' do
    it 'Guest cannot visit admin page' do
      visit(admin_root_path)
      expect(response).to render_template 'devise/sessions/new'
    end
  end
end
