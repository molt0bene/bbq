require 'rails_helper'

RSpec.describe EventPolicy do
  include Devise::Test::IntegrationHelpers

  subject { EventPolicy.new(user, event) }

  let(:user) { User.create(name: 'Vasya', email: 'aa@aa.aa', password: '123456') }
  let(:event) { Event.create(title: 'Test event', description: '123', address: 'Moscow', datetime: DateTime.now, user_id: 1) }

  describe 'user visits event with no pincode' do
    context 'anonymous user' do
      let(:user) { nil }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end

    context 'logged in user, not an owner' do
      let(:another_user) { User.create(name: 'Petya', email: 'bb@bb.bb', password: '654321') }

      before do
        login_as another_user
      end

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end

    context 'owner' do
      before do
        login_as user
      end

      it { is_expected.to permit_actions(%i[show edit update destroy]) }
    end
  end
end
