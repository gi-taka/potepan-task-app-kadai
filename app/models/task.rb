class Task < ApplicationRecord
  validates :title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_end_check

  private

  def start_end_check
    errors.add(:end_at, "は開始日より前にはできません") if end_at.to_i < start_at.to_i
  end
end
