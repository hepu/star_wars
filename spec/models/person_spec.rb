require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { build(:person) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    context 'without name' do
      subject { build(:person, name: nil) }

      it { is_expected.not_to be_valid }
    end

    context 'without planet' do
      subject { build(:person, planet: nil) }

      it { is_expected.not_to be_valid }
    end
  end
end
