require 'rails_helper'

RSpec.describe Film, type: :model do
  subject { build(:film) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      is_expected.to be_valid
    end

    context 'without title' do
      subject { build(:film, title: nil) }

      it { is_expected.not_to be_valid }
    end
  end
end
