# frozen_string_literal: true

class DeviceData
  attr_accessor :readings, :cumulative_count, :latest_timestamp

  def initialize
    @readings = {}
    @cumulative_count = 0
    @latest_timestamp = nil
  end
end
