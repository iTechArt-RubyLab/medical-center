class NotificationWorker
  include Sidekiq::Worker

  def perform
    Visit.where(date: Date.tomorrow).each do |visit|
      doctor = visit.user
      patient = visit.patient
      visit_date = visit.date
      visit_cabinet = visit.cabinet

      UserMailer.with(receiver: doctor, visit_cabinet: visit_cabinet, visit_date: visit_date,
                      host: host).appointment_notification.deliver_now
      UserMailer.with(receiver: patient, visit_cabinet: visit_cabinet, visit_date: visit_date,
                      host: host).appointment_notification.deliver_now
    end
  end
end
