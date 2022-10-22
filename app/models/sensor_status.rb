class SensorStatus < ApplicationRecord

  belongs_to :sensor

  STATUS_TYPES = {
    pending: 0,
    completed: 1
  }.freeze

end