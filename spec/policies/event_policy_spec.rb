require 'rails_helper'

RSpec.describe EventPolicy do
  include Devise::Test::IntegrationHelpers
  include Pundit::Authorization

  subject { EventPolicy.new(user, event) }

  describe 'user visits event with no pincode' do
    let(:user) { UserContext.new(User.create(name: 'Vasya', email: 'aa@aa.aa', password: '123456'), { }) }
    let(:event) { Event.create(title: 'Test event', description: '123', address: 'Moscow', datetime: DateTime.now, user_id: 1)}

    context 'anonymous user' do
      let(:user) { nil }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to forbid_actions(%i[edit update destroy]) }
    end

    context 'logged in user, not an owner' do
      let(:another_user) { UserContext.new(User.create(name: 'Petya', email: 'bb@bb.bb', password: '654321'), { }) }

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

  describe 'user visits event with a pincode' do
    let(:user) { UserContext.new(User.create(name: 'Vasya', email: 'aa@aa.aa', password: '123456'), { }) }
    let(:event) { Event.create(title: 'Test event', description: '123', address: 'Moscow', datetime: DateTime.now, user_id: 1,
                               pincode: '777')}

    context 'owner of the event' do
      before do
        login_as user
      end

      it { is_expected.to permit_action(:show) }
    end

    context 'other users' do
      let(:another_user) { UserContext.new(User.create(name: 'Petya', email: 'bb@bb.bb', password: '654321'), { }) }

      before do
        login_as another_user
      end

      describe 'when the pincode is nil' do
        it { is_expected.to forbid_action(:show) }
      end

      describe 'when the pincode is incorrect' do
        before do
          user.cookies["events_#{event.id}_pincode"] = '111'
        end

        it { is_expected.to forbid_action(:show) }
      end

      describe 'when the pincode is correct' do
        before do
          user.cookies["events_#{event.id}_pincode"] = '777'
        end

        it { is_expected.to permit_action(:show) }
      end
    end
  end
end
