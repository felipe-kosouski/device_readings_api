require 'rails_helper'

RSpec.describe "Readings", type: :request do
  let(:device_id) { "36d5658a-6908-479e-887e-a949ec199272" }
  let(:device_data) { DeviceStore.find_or_create(device_id) }
  let(:device_service) { DeviceService.new(device_data) }

  let(:valid_readings) do
    [
      { timestamp: "2021-09-29T16:08:15+01:00", count: 10 },
      { timestamp: "2021-09-29T16:09:15+01:00", count: 20 }
    ]
  end

  describe "POST /create" do
    it "adds readings and returns success message" do
      post "/readings", params: { device_id: device_id, readings: valid_readings }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Readings added successfully")
    end

    it "returns error message for invalid readings" do
      allow_any_instance_of(DeviceService).to receive(:add_reading).and_raise(StandardError, "Invalid reading")

      post "/readings", params: { device_id: device_id, readings: valid_readings }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["message"]).to eq("Invalid reading")
    end
  end

  describe "GET /latest_timestamp" do
    #   missed to implement this
  end

  describe "GET /cumulative_count" do
    #   missed to implement this
  end
end
