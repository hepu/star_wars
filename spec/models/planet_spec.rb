require 'rails_helper'

RSpec.describe Planet, type: :model do
  subject { build(:planet) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    context 'without name' do
      subject { build(:planet, name: nil) }

      it { is_expected.not_to be_valid }
    end
  end
end
