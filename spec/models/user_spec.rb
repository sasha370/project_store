# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_presence_of(:password) }

  context 'password validation' do
    it { should_not allow_value('bad').for(:password) }
    it { should_not allow_value('12345678').for(:password) }
    it { should_not allow_value('12345678a').for(:password) }
    it { should_not allow_value('12345678A').for(:password) }
    it { should_not allow_value('aaaaaaaaa').for(:password) }
    it { should_not allow_value('AAAAAAAAA').for(:password) }
    it { should_not allow_value('aAaaaaaaa').for(:password) }
    it { should_not allow_value('AAAAAAAAa').for(:password) }
    it { should allow_value('AAAaaa123').for(:password) }
  end
end
