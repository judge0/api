require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do

  let(:submission) { create(:submission) }

  describe "GET #show" do
    it "returns one submission" do
      get :show, params: {id: submission.id}
      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_serialized(submission).with(SubmissionSerializer)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Submission" do
        expect {
          post :create, params: { submission: attributes_for(:valid_submission) }
        }.to change(Submission, :count).by(1)
      end

      it "returns only id of new Submission" do
        post :create, params: { submission: attributes_for(:valid_submission) }
        json = JSON.parse(response.body)
        expect(response).to be_success
        expect(json).to have_serialized(Submission.first).with(SubmissionCreateSerializer)
      end
    end

    context "with invalid params" do
      it "doesn't create new Submission" do
        post :create, params: { submission: attributes_for(:invalid_submission) }
        expect(response).to have_http_status(422)
      end
    end
  end
end