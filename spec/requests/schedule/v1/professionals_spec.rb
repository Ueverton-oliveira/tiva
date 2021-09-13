require "rails_helper"

describe "GET/Professionals", type: :request do
  let(:url) { '/schedule/v1/professional' }
  it "tests home" do
    get url
    expect(body_json['professionals']).to contain_exactly *categories.as_json(only: %i(id name description email cell_phone))
  end

  it "tests home" do
    get url
    expect(response).to have_http_status(:ok)
  end
end