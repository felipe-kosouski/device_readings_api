require 'rails_helper'

RSpec.describe DeviceStore, type: :repository do
  let(:device_id) { "36d5658a-6908-479e-887e-a949ec199272" }

  describe '#find_or_create' do
    context 'when the device data does not exist' do
      it 'creates a new device data instance' do
        device_data = DeviceStore.find_or_create(device_id)
        expect(device_data).to be_a(DeviceData)
      end

      it 'stores the device data instance in the devices hash' do
        device_data = DeviceStore.find_or_create(device_id)
        expect(DeviceStore.devices[device_id]).to eq(device_data)
      end
    end

    context 'when the device data already exists' do
      it 'returns the existing device data instance' do
        device_data = DeviceStore.find_or_create(device_id)
        expect(DeviceStore.find_or_create(device_id)).to eq(device_data)
      end
    end
  end
end
