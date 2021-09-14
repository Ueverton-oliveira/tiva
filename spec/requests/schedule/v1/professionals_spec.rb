require "rails_helper"

describe "Api::V1::Professionals", type: :request do
  context "GET /professionals" do
    let(:url) { "/api/v1/professionals" }
    let!(:professionals) { create(:professional) }

    it "returns all Professioanls" do
      get url, params: professionals, xhr: true
      expect(body_json['parms_professionals']).to contain_exactly *parms_professionals.as_json(only: %i(id name description email cell_phone))
    end

    it "returns success status" do
      get url, params: professionals, xhr: true
      expect(response).to have_http_status(:ok)
      binding.pry
    end
  end
end