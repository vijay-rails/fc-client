require 'singleton'

class SpaceShip < ApplicationRecord
  include Singleton

  @comms_up = true

  def self.get_comms_up
    @comms_up
  end

  def self.set_comms_up value
    @comms_up = value
  end
end
