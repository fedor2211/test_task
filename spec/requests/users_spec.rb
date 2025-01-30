describe "/users", type: :request do
  describe "GET /index" do
    before { create_list(:user, 2) }

    it "renders a successful response" do
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:user) { create(:user) }

    it "renders a successful response" do
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:user) { create(:user) }

    it "renders a successful response" do
      get edit_user_url(user)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:interests) { create_list(:interest, 2) }
    let(:skills) { create_list(:skill, 2) }
    let(:attributes) do
      {
        name: "name",
        patronymic: "patronymic",
        surname: "surname",
        email: "example@example.com",
        age: "24",
        nationality: "nation",
        country: "country",
        gender: 1,
        interests: interests.map(&:id),
        skills: skills.map(&:id)
      }
    end

    it "creates a new User" do
      expect {
        post users_url, params: { user: attributes }
      }.to change(User, :count).by(1)
    end

    it "redirects to the created user" do
      post users_url, params: { user: attributes }
      expect(response).to redirect_to(user_url(User.last))
    end

    context "with invalid parameters" do
      let(:attributes) { { name: "" } }

      it "does not create a new User" do
        expect {
          post users_url, params: { user: attributes }
        }.to change(User, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post users_url, params: { user: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    let!(:user) { create(:user) }
    let(:interests) { create_list(:interest, 2) }
    let(:skills) { create_list(:skill, 2) }
    let(:attributes) { { name: "new name", interests: [ interests.first.id ], skills: [ skills.first.id ] } }

    it "updates the requested user" do
      patch user_url(user), params: { user: attributes }
      user.reload
      expect(user.name).to eq("new name")
    end

    it "redirects to the user" do
      patch user_url(user), params: { user: attributes }
      user.reload
      expect(response).to redirect_to(user_url(user))
    end

    context "with invalid parameters" do
      let(:attributes) { { name: "" } }

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        patch user_url(user), params: { user: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:user) { create(:user) }

    it "destroys the requested user" do
      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete user_url(user)
      expect(response).to redirect_to(users_url)
    end
  end
end
