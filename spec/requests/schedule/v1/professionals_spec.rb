require "rails_helper"

describe "Professionals", type: :request do
  let!(:professionals) { create(:professional) }

  it "returns all Professioanls" do
    binding.pry
    get '/schedule/v1/professionals'
    expect(body_json['professionals']).to contain_exactly *professionals.as_json(only: %i(id name description email cell_phone))
  end

  it "returns success status" do
    get '/schedule/v1/professionals'
    expect(response).to have_http_status(:ok)
  end
end