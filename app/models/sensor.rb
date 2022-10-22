class Sensor < ApplicationRecord

  has_one :sensor_status, dependent: :destroy

  after_create_commit :create_sensor_status

  private

  def create_sensor_status
    SensorStatus.create!(sensor: self, status: SensorStatus::STATUS_TYPES[:pending])
  end
end
