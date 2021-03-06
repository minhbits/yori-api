# frozen_string_literal: true

class Recipe < ApplicationRecord
  validates :title, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
