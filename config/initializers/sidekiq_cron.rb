Sidekiq::Cron::Job.create(name: 'Notification worker - every day', cron: '0 4 * * *', class: 'NotificationWorker')
