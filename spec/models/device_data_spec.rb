require 'rails_helper'

RSpec.describe DeviceData, type: :model do
  let(:device_data) { DeviceData.new }

  it 'initializes with an empty readings hash' do
    expect(device_data.readings).to eq({})
  end

  it 'initializes with a cumulative count of 0' do
    expect(device_data.cumulative_count).to eq(0)
  end

  it 'initializes with a nil latest timestamp' do
    expect(device_data.latest_timestamp).to be_nil
  end
end
