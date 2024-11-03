class DeviceStore
  def self.devices
    @devices ||= {}
  end

  def self.find_or_create(device_id)
    devices[device_id] ||= DeviceData.new
  end
end
