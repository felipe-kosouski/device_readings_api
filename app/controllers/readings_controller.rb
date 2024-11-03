class ReadingsController < ApplicationController
  before_action :set_device_service

  def create
    readings = params[:readings]

    readings.each do |reading|
      timestamp = Time.parse(reading[:timestamp])
      count = reading[:count].to_i
      @device_service.add_reading(timestamp, count)
    end

    render json: { message: "Readings added successfully" }, status: :ok
  rescue StandardError => e
    render json: { message: e.message }, status: :unprocessable_content
  end

  def latest_timestamp
    if @device_service&.latest_timestamp
      render json: { latest_timestamp: @device_service.latest_timestamp.iso8601 }, status: :ok
    else
      render json: { message: "Device not found" }, status: :not_found
    end
  end

  def cumulative_count
    if @device_service
      render json: { cumulative_count: @device_service.cumulative_count }, status: :ok
    else
      render json: { message: "Device not found" }, status: :not_found
    end
  end

  private

  def set_device_service
    device_id = params[:device_id] || params[:id]
    device_data = DeviceStore.find_or_create(device_id)
    @device_service = DeviceService.new(device_data)
  end
end
