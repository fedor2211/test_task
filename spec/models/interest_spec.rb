describe Interest, type: :model do
  subject { build :interest }

  it { is_expected.to have_many(:user_interests) }
  it { is_expected.to have_many(:users).through(:user_interests) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
