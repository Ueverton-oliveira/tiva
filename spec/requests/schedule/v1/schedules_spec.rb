require "rails_helper"

describe "Api::V1::Professionals", type: :request do
  context "GET /professionals" do
    let(:url) { "/api/v1/professionals" }
    let!(:professionals) { create(:professional) }

    it "returns all Professioanls" do
      get url, params: professionals, xhr: true
      expect(body_json['professionals']).to contain_exactly professionals.as_json(only: %i(id name description email cell_phone))
    end

    it "returns success status" do
      get url, params: professionals, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /professionals" do
    let(:url) { "/api/v1/professionals" }

    context "with valid params " do
      let!(:professionals) { create(:professional) }
      let(:professional_params) { { professional: attributes_for(:professional) }.to_json }

      it 'adds a new Professional' do
        expect do
          post url, params: professional_params
        end.to change(Professional, :count).by(1)
      end

      it 'returns last added Professional' do
        post url, params: professional_params
        expected_category = Professional.last.as_json(only: %i(id name description email cell_phone))
        expect(body_json['professionals']).to eq expected_category
      end

      it 'returns success status' do
        post url, params: professional_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params " do
      let(:professional_invalid_params) do
        { professional: attributes_for(:professional, name: nil) }.to_json
      end

      it 'does not add a new Professional' do
        expect do
          post url, params: professional_invalid_params
        end.to_not change(Professional, :count)
      end

      it 'returns error message' do
        post url, params: professional_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, params: professional_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PACHT /professionals/:id" do
    let(:professional) { create(:professional) }
    let(:url) { "/api/v1/professionals/#{professional.id}" }

    context "with valid paramns" do
      let(:new_name) { 'Goku' }
      let(:professional_params) { { professional: {name: new_name}}.to_json}

      it 'update Professional' do
        patch url, params: professional_params
        professional.reload
        expect(professional.name).to eq new_name
      end

      it 'retuns update Professional' do
        patch url, params: professional_params
        professional.reload
        expect_category = professional.as_json(only: %i(id name))
        expect(body_json['professional']).to eq expect_category
      end
    end

    context "with invalid paramns" do
      let(:professional_invalid_params) do
        { professional: attributes_for(:professional, name: nil) }.to_json
      end

      it 'does not update Professional' do
        old_name = professional.name
        patch url, params: professional_invalid_params
        professional.reload
        expect(professional.name).to eq old_name
      end

      it 'returns unprocessable_entity status' do
        patch url, params: professional_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        patch url, params: professional_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end
    end
  end

  context "DELETE /professionals" do
    let!(:professional) { create(:professional) }
    let(:url) { "/api/v1/professionals/#{professional.id}" }

    it 'removes Professional' do
      expect do
        delete url
      end.to change(Professional, :count).by(-1)
    end

    it 'returns success status' do
      delete url
      expect(response).to have_http_status(:no_content)
    end

    it 'does not return any body content' do
      delete url
      expect(body_json).to_not be_present
    end
  end
end