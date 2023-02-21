require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    context 'without name' do
      subject { build(:user, username: nil) }

      it { is_expected.not_to be_valid }
    end

    context 'without password' do
      subject { build(:user, password: nil, password_confirmation: nil) }

      it { is_expected.not_to be_valid }
    end
  end
end
