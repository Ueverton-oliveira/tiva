require "rails_helper"

describe "Api::V1::Professionals", type: :request do
  context "GET /professionals" do
    let(:url) { "/api/v1/professionals" }
    let!(:professionals) { create_list(:professional, 5) }

    it "returns all Professioanls" do
      get url,
      expect(body_json['professionals']).to contain_exactly *professionals.as_json(only: %i(id name))

    end

  end
end