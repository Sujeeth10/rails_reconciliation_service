class Transaction < ApplicationRecord
  validates :txn_id, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :status, presence: true

  def self.upsert_by_txn(attrs)
    txn_id = attrs[:txn_id]
    attrs = attrs.slice(:txn_id, :amount, :status, :processed_at).compact
    Transaction.upsert(attrs, unique_by: :txn_id)
  end
end
