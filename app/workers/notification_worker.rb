class NotificationWorker
  include Sidekiq::Worker

  def perform
    Visit.where(date: Date.tomorrow).each do |visit|
      doctor = visit.user
      patient = visit.patient
      visit_date = visit.date
      visit_room = visit.cabinet

      call_mailer(doctor, visit_room, visit_date)
      call_mailer(patient, visit_room, visit_date)
    end
  end

  private

  def call_mailer(receiver, visit_room, visit_date)
    UserMailer.with(receiver: receiver, visit_room: visit_room, visit_date: visit_date,
                    host: host).appointment_notification.deliver_now
  end

  def host
    Rails.env.production? ? 'morning-plains-26206.herokuapp.com' : 'http://localhost:3000'
  end
end
