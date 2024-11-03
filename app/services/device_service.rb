class DeviceService
  def initialize(device_data)
    @device_data = device_data
  end

  def add_reading(timestamp, count)
    return if reading_exists?(timestamp)

    store_reading(timestamp, count)
    update_cumulative_count(count)
    update_latest_timestamp(timestamp)
  end

  def cumulative_count
    @device_data.cumulative_count
  end

  def latest_timestamp
    @device_data.latest_timestamp
  end

  private

  def reading_exists?(timestamp)
    @device_data.readings.key?(timestamp)
  end

  def store_reading(timestamp, count)
    @device_data.readings[timestamp] = count
  end

  def update_cumulative_count(count)
    @device_data.cumulative_count += count
  end

  def update_latest_timestamp(timestamp)
    return unless @device_data.latest_timestamp.nil? || timestamp > @device_data.latest_timestamp

    @device_data.latest_timestamp = timestamp
  end
end
