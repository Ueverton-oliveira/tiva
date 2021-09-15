require "rails_helper"

describe "Api::V1::Adresses", type: :request do
  context "GET adresses" do
    let(:url) { "/api/v1/adresses" }
    let!(:professional) { create(:professional) }
    let(:adresses) { create(:address, professional_id: professional.id) }

    it "returns all Adresses" do
      get url, params: adresses, xhr: true
      expect(body_json['adresses']).to contain_exactly adresses.as_json(only: %i(zip_code state city district street house_number))
    end

    it "returns success status" do
      get url, params: adresses, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /adresses" do
    let(:url) { "/api/v1/adresses"  }

    context "with valid params " do
      let!(:professional) { create(:professional) }
      let(:adresses) { create(:address, professional_id: professional.id) }
      let(:address_params) { { address: attributes_for(:address) }.to_json }

      it 'adds a new Address' do
        byebug
        expect do
          post url, params: address_params
        end.to change(Address, :count).by(1)
      end

      it 'returns last added Address' do
        post url, params: address_params
        expected_address = Address.last.as_json(only: %i(zip_code state city district street house_number))
        expect(body_json['adresses']).to eq expected_address
      end

      it 'returns success status' do
        post url, params: address_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params " do
      let(:address_invalid_params) do
        { address: attributes_for(:address, zip_code: nil) }.to_json
      end

      it 'does not add a new Address' do
        expect do
          post url, params: address_invalid_params
        end.to_not change(Address, :count)
      end

      it 'returns error message' do
        post url, params: address_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, params: address_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PACHT /adresses/:id" do
    let(:address) { create(:address) }
    let(:url) { "/api/v1/adresses/#{adresses.id}" }

    context "with valid paramns" do
      let(:zip_code) { '79280-000' }
      let(:address_params) { { address: {zip_code: zip_code}}.to_json}

      it 'update Professional' do
        patch url, params: address_params
        address.reload
        expect(address.name).to eq zip_code
      end

      it 'retuns update Professional' do
        patch url, params: address_params
        address.reload
        expected_address = address.as_json(only: %i(zip_code state city district street house_number))
        expect(body_json['address']).to eq expected_address
      end
    end

    context "with invalid paramns" do
      let(:address_invalid_params) do
        { address: attributes_for(:address, zip_code: nil) }.to_json
      end

      it 'does not update Professional' do
        old_zip_code = address.zip_code
        patch url, params: address_invalid_params
        address.reload
        expect(address.zip_code).to eq old_zip_code
      end

      it 'returns unprocessable_entity status' do
        patch url, params: address_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        patch url, params: address_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end
    end
  end

  context "DELETE /adresses" do
    let!(:address) { create(:address) }
    let(:url) { "/api/v1/adresses/#{address.id}" }

    it 'removes Address' do
      expect do
        delete url
      end.to change(Address, :count).by(-1)
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