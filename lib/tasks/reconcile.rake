namespace :reconcile do
  desc 'Run reconciliation summary'
  task run: :environment do
    puts 'Running reconciliation...'
    totals = Transaction.group(:status).count
    totals.each do |status, count|
      puts "Status: #{status} => Count: #{count}"
    end
    puts 'Done.'
  end
end
