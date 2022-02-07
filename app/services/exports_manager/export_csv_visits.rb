require 'csv'

module ExportsManager
  class ExportCsvVisits
    attr_reader :filters

    def initialize(filters: {})
      @filters = filters
    end

    def call
      CSV.open(full_filename, 'w') do |csv|
        csv << headers

        visits.each do |visit|
          csv << visit_in_row(visit)
        end
      end

      { filename: full_filename }
    end

    private

    def filename
      "visits_report_#{Time.zone.now.strftime('%T %F').tr(':', '-')}.csv"
    end

    def full_filename
      @full_filename ||= Rails.root.join('app', 'assets', 'reports', filename)
    end

    def headers
      %w[id cabinet date notes created_at updated_at user_id patient_id sick_leave_id visit_id diagnosis_ids]
    end

    def visit_in_row(visit)
      [
        visit.id,
        visit.cabinet,
        visit.date,
        visit.notes,
        visit.created_at,
        visit.updated_at,
        visit.user_id,
        visit.patient_id,
        visit.sick_leave_id,
        visit.visit_id,
        visit.diagnosis_ids
      ]
    end

    def visits
      @visits ||= VisitManager::ListVisits.new(filters: filters).call
    end
  end
end
