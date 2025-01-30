describe "/skills", type: :request do
  describe "GET /index" do
    before { create_list(:skill, 2) }

    it "renders a successful response" do
      get skills_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let!(:skill) { create(:skill) }

    it "renders a successful response" do
      get skill_url(skill)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_skill_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:skill) { create(:skill) }

    it "renders a successful response" do
      get edit_skill_url(skill)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:attributes) { { name: "name" } }

    it "creates a new Skill" do
      expect {
        post skills_url, params: { skill: attributes }
      }.to change(Skill, :count).by(1)
    end

    it "redirects to the created skill" do
      post skills_url, params: { skill: attributes }
      expect(response).to redirect_to(skill_url(Skill.last))
    end

    context "with invalid parameters" do
      let(:attributes) { { name: "" } }
      it "does not create a new Skill" do
        expect {
          post skills_url, params: { skill: attributes }
        }.to change(Skill, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post skills_url, params: { skill: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let!(:skill) { create(:skill) }
    let(:attributes) { { name: "new name" } }

    it "updates the requested skill" do
      patch skill_url(skill), params: { skill: attributes }
      skill.reload
      expect(skill.name).to eq("new name")
    end

    it "redirects to the skill" do
      patch skill_url(skill), params: { skill: attributes }
      skill.reload
      expect(response).to redirect_to(skill_url(skill))
    end

    context "with invalid parameters" do
      let(:attributes) { { name: "" } }

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch skill_url(skill), params: { skill: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:skill) { create(:skill) }

    it "destroys the requested skill" do
      expect {
        delete skill_url(skill)
      }.to change(Skill, :count).by(-1)
    end

    it "redirects to the skills list" do
      delete skill_url(skill)
      expect(response).to redirect_to(skills_url)
    end
  end
end
