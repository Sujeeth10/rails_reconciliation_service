Rails Reconciliation Service

A prototype microservice built with Ruby on Rails and PostgreSQL, containerized using Docker, for reconciling transaction data between two systems (e.g., Bank vs Internal Ledger).

This project simulates real-world fintech reconciliation workflows where financial institutions validate and reconcile data from multiple sources to detect mismatches, missing entries, or duplicates.

🚀 Features

REST API for ingesting transactions from System A and System B.

Reconciliation job that:

Matches transactions across systems by transaction_id + amount + date.

Flags mismatched or missing transactions.

Generates reconciliation reports (JSON).

Background jobs (Sidekiq) to handle reconciliation asynchronously.

PostgreSQL as the source of truth.

Fully containerized with Docker.

🛠 Tech Stack

Ruby on Rails 7

PostgreSQL

Sidekiq (for background jobs)

Redis (job queue)

Docker & Docker Compose

📂 Project Structure
rails_reconciliation_service/
│── app/                # Rails app code
│   ├── controllers/    # REST API controllers
│   ├── models/         # ActiveRecord models
│   ├── jobs/           # Sidekiq jobs
│── config/             # DB & environment configs
│── db/                 # Migrations & schema
│── Dockerfile          # Rails container
│── docker-compose.yml  # Multi-container setup
│── README.md           # Project documentation

⚙️ Setup & Installation
1️⃣ Clone Repo
git clone https://github.com/your-username/rails_reconciliation_service.git
cd rails_reconciliation_service

2️⃣ Build & Run with Docker
docker-compose build
docker-compose up

3️⃣ Setup Database

In a separate terminal:

docker-compose run web rails db:create db:migrate

🔑 API Endpoints
1. Ingest Transactions

POST /transactions/system_a

POST /transactions/system_b

Payload Example:

{
  "transaction_id": "TXN123",
  "amount": 150.50,
  "currency": "USD",
  "date": "2025-01-10"
}

2. Trigger Reconciliation

POST /reconcile/run
Runs reconciliation in the background.

3. Get Reconciliation Report

GET /reconcile/report

Response Example:

{
  "matched": [
    { "transaction_id": "TXN123", "amount": 150.50 }
  ],
  "unmatched_system_a": [
    { "transaction_id": "TXN456", "amount": 200.00 }
  ],
  "unmatched_system_b": []
}

🧪 Running Tests
docker-compose run web rspec

📊 Future Enhancements

Support for CSV uploads.

Reconciliation with tolerance thresholds (e.g., +/- 0.01).

Web dashboard for reconciliation status.