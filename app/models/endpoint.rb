class Endpoint < ApplicationRecord
  validates :path, presence: true
  validates :verb, presence: true, inclusion: { in: %w[get post patch put delete] }, uniqueness: { scope: :path }
  validates :code, presence: true, inclusion: { in: Rack::Utils::HTTP_STATUS_CODES }

  default_scope -> {
    where(deletion_date: nil)
  }

  def soft_delete
    update_column("deletion_date", Time.now)
  end
end
