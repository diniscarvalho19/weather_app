# frozen_string_literal: true

class Location < ApplicationRecord
  # VALIDATIONS
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
