require 'rails_helper'

RSpec.describe DeviceService, type: :service do
  let(:device_data) { DeviceData.new }
  let(:device_service) { DeviceService.new(device_data) }

  describe '#add_reading' do
    let(:timestamp1) { Time.parse('2021-09-29T16:08:15+01:00') }
    let(:timestamp2) { Time.parse('2021-09-29T16:09:15+01:00') }

    context 'when the reading does not exist' do
      it 'stores the reading' do
        device_service.add_reading(timestamp1, 5)
        expect(device_data.readings[timestamp1]).to eq(5)
      end

      it 'updates the cumulative count' do
        device_service.add_reading(timestamp1, 5)
        device_service.add_reading(timestamp2, 10)
        expect(device_data.cumulative_count).to eq(15)
      end

      it 'updates the latest timestamp' do
        device_service.add_reading(timestamp1, 5)
        device_service.add_reading(timestamp2, 10)
        expect(device_data.latest_timestamp).to eq(timestamp2)
      end
    end

    context 'when the reading is duplicated' do
      it 'ignores the reading' do
        device_service.add_reading(timestamp1, 5)
        device_service.add_reading(timestamp1, 10)
        expect(device_data.readings[timestamp1]).to eq(5)
        expect(device_data.cumulative_count).to eq(5)
      end
    end

  end

  describe '#cumulative_count' do
    it 'returns the cumulative count' do
      device_service.add_reading(Time.now, 5)
      expect(device_service.cumulative_count).to eq(5)
    end
  end

  describe '#latest_timestamp' do
    it 'returns the latest timestamp' do
      timestamp = Time.now
      device_service.add_reading(timestamp, 5)
      expect(device_service.latest_timestamp).to eq(timestamp)
    end
  end
end
