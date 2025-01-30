describe "/interests", type: :request do
  describe "GET /index" do
    before { create_list(:interest, 2) }

    it "renders a successful response" do
      get interests_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:interest) { create(:interest) }

    it "renders a successful response" do
      get interest_url(interest)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_interest_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let(:interest) { create(:interest) }

    it "renders a successful response" do
      get edit_interest_url(interest)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    let(:attributes) do
      { name: "name" }
    end

    it "creates a new Interest" do
      expect {
        post interests_url, params: { interest: attributes }
      }.to change(Interest, :count).by(1)
    end

    it "redirects to the created interest" do
      post interests_url, params: { interest: attributes }
      expect(response).to redirect_to(interest_url(Interest.last))
    end

    context "with invalid parameters" do
      let(:attributes) { {} }

      it "does not create a new Interest" do
        expect {
          post interests_url, params: { interest: attributes }
        }.to change(Interest, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post interests_url, params: { interest: attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    before { patch interest_url(interest), params: { interest: new_attributes } }

    let(:new_attributes) do
      { name: "new name" }
    end
    let!(:interest) { create(:interest) }

    it "updates the requested interest" do
      interest.reload
      expect(interest.name).to eq("new name")
    end

    it "redirects to the interest" do
      interest.reload
      expect(response).to redirect_to(interest_url(interest))
    end

    context "with invalid parameters" do
      let(:new_attributes) do
        { name: "" }
      end

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:interest) { create(:interest) }

    it "destroys the requested interest" do
      expect {
        delete interest_url(interest)
      }.to change(Interest, :count).by(-1)
    end

    it "redirects to the interests list" do
      delete interest_url(interest)
      expect(response).to redirect_to(interests_url)
    end
  end
end
