class TransactionsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @transactions = Transaction.order(created_at: :desc).limit(100)
    render json: @transactions
  end

  def create
    payload = params.permit(:txn_id, :amount, :status, :processed_at)
    Transaction.upsert_by_txn(payload.to_h.symbolize_keys)
    render json: { success: true }, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def reconcile
    totals = Transaction.group(:status).select("status, COUNT(*) as count, SUM(amount) as total_amount")
    render json: totals.map { |r| { status: r.status, count: r.count.to_i, total_amount: r.total_amount.to_f } }
  end
end
