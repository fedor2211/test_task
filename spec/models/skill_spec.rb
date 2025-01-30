describe Skill, type: :model do
  subject { create(:skill) }

  it { is_expected.to have_many(:user_skills) }
  it { is_expected.to have_many(:users).through(:user_skills) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
