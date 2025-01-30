describe Users::Create do
  subject(:run) { described_class.run(params) }

  let(:params) do
    {
      name: "name",
      patronymic: "patronymic",
      surname: "surname",
      email: "user@user.com",
      age: "14",
      nationality: "nation",
      country: "country",
      gender: User.genders[:male]
    }
  end

  it "creates user" do
    expect { run }.to change { User.count }.by(1)
  end

  it "works correctly" do
    expect(run).to be_valid
  end

  context "when interests present" do
    before { params[:interests] = interests.map(&:id) }

    let(:interests) { create_list(:interest, 2) }

    it "creates user" do
      expect { run }.to change { User.count }.by(1)
    end

    it "adds interests to user" do
      run
      expect(User.last.interests).to match_array(interests)
    end

    it "works correctly" do
      expect(run).to be_valid
    end
  end

  context "when skills present" do
    before { params[:skills] = skills.map(&:id) }

    let(:skills) { create_list(:skill, 2) }

    it "creates user" do
      expect { run }.to change { User.count }.by(1)
    end

    it "adds interests to user" do
      run
      expect(User.last.skills).to match_array(skills)
    end

    it "works correctly" do
      expect(run).to be_valid
    end
  end

  context "when email is invalid" do
    before { params[:email] = "example@example" }

    it { expect(run).not_to be_valid }

    it "does not create user" do
      expect { run }.to change { User.count }.by(0)
    end

    it "adds errors" do
      expect(run.errors.full_messages).to contain_exactly("Email is invalid")
    end
  end

  context "when age is invalid" do
    context "and equal to 0" do
      before { params[:age] = "0" }

      it { expect(run).not_to be_valid }

      it "does not create user" do
        expect { run }.to change { User.count }.by(0)
      end

      it "adds errors" do
        expect(run.errors.full_messages).to contain_exactly("Age must be greater than 0")
      end
    end

    context "and above 90" do
      before { params[:age] = "91" }

      it { expect(run).not_to be_valid }

      it "does not create user" do
        expect { run }.to change { User.count }.by(0)
      end

      it "adds errors" do
        expect(run.errors.full_messages).to contain_exactly("Age must be less than or equal to 90")
      end
    end
  end
end
