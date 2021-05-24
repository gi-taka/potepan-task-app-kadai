class Task < ApplicationRecord
  validates :title, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :start_end_check

  private

  def start_end_check
    errors.add(:end_at, "は開始日より前にはできません") if end_at == true && start_at == true && end_at < start_at
  end
end
