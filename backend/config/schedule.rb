set :output, "log/cron.log"

every 5.minutes do
  rake "kafka:retry"
end
