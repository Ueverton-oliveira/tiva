require "rails_helper"

describe "Professionals", type: :request do

  it "tests home" do
    get '/schedule/v1/professional'
    expect(body_json).to eq({ 'message' => 'Uhul!' })
  end

  it "tests home" do
    get '/schedule/v1/professional'
    expect(response).to have_http_status(:ok)
  end
end