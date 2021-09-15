require "rails_helper"

describe "Api::V1::Schedules", type: :request do
  context "GET schedules" do
    let(:url) { "/api/v1/schedules" }
    let!(:schedules) { create(:schedule) }

    it "returns all Adresses" do
      get url, params: schedules, xhr: true
      expect(body_json['schedules']).to contain_exactly schedules.as_json(only: %i(initial_date end_date initial_hour end_hour))
    end

    it "returns success status" do
      get url, params: schedules, xhr: true
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /schedules" do
    let(:url) { "/api/v1/schedules"  }

    context "with valid params " do
      let!(:schedules) { create(:schedule) }
      let(:schedule_params) { { schedule: attributes_for(:schedule) }.to_json }

      it 'adds a new Schedule' do
        expect do
          post url, params: schedule_params
        end.to change(Schedule, :count).by(1)
      end

      it 'returns last added Schedule' do
        post url, params: schedule_params
        expected_category = Schedule.last.as_json(only: %i(initial_date end_date initial_hour end_hour))
        expect(body_json['schedules']).to eq expected_category
      end

      it 'returns success status' do
        post url, params: schedule_params
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params " do
      let(:schedule_invalid_params) do
        { schedule: attributes_for(:schedule, initial_date: nil) }.to_json
      end

      it 'does not add a new Schedule' do
        expect do
          post url, params: schedule_invalid_params
        end.to_not change(Schedule, :count)
      end

      it 'returns error message' do
        post url, params: schedule_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, params: schedule_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context "PACHT /schedules/:id" do
    let(:schedule) { create(:schedule) }
    let(:url) { "/api/v1/schedules/#{shedules.id}" }

    context "with valid paramns" do
      let(:initial_date) { '15/09/2021' }
      let(:schedule_params) { { schedule: {initial_date: initial_date}}.to_json}

      it 'update Schedule' do
        patch url, params: schedule_params
        schedule.reload
        expect(schedule.initial_date).to eq initial_date
      end

      it 'retuns update Professional' do
        patch url, params: schedule_params
        address.reload
        expect_category = schedule.as_json(only: %i(initial_date end_date initial_hour end_hour))
        expect(body_json['api']).to eq expect_category
      end
    end

    context "with invalid paramns" do
      let(:schedule_invalid_params) do
        { schedule: attributes_for(:schedule, initial_date: nil) }.to_json
      end

      it 'does not update Professional' do
        old_initial_date = schedule.initial_date
        patch url, params: schedule_invalid_params
        schedule.reload
        expect(schedule.initial_date).to eq old_initial_date
      end

      it 'returns unprocessable_entity status' do
        patch url, params: schedule_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        patch url, params: schedule_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end
    end
  end

  context "DELETE /adresses" do
    let!(:schedule) { create(:schedule) }
    let(:url) { "/api/v1/schedules/#{schedule.id}" }

    it 'removes Schedule' do
      expect do
        delete url
      end.to change(Schedule, :count).by(-1)
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