describe User, type: :model do
  subject { create(:user) }

  it { is_expected.to have_many(:user_interests) }
  it { is_expected.to have_many(:user_skills) }
  it { is_expected.to have_many(:interests).through(:user_interests) }
  it { is_expected.to have_many(:skills).through(:user_skills) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to define_enum_for(:gender).with_values(%i[male female]) }
end
