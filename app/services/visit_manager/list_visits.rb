module VisitManager
  class ListVisits
    include WithApplyConditions

    attr_reader :filters

    def initialize(filters: {})
      @filters = filters.symbolize_keys
    end

    def call
      apply_conditions(
        collection,
        start_at_condition,
        end_at_condition,
        user_condition,
        patient_condition,
        with_sick_leave_condition
      )
    end

    def table
      Visit.arel_table
    end

    def collection
      return Visit.all if filters[:diagnosis_id].blank?

      Visit.joins(:diagnoses).where(diagnoses: { id: filters[:diagnosis_id] })
    end

    def start_at_condition
      return if filters[:start_at].blank?

      table[:date].gteq(filters[:start_at])
    end

    def end_at_condition
      return if filters[:end_at].blank?

      table[:date].lteq(filters[:end_at])
    end

    def user_condition
      return if filters[:user_id].blank?

      table[:user_id].eq(filters[:user_id])
    end

    def patient_condition
      return if filters[:patient_id].blank?

      table[:patient_id].eq(filters[:patient_id])
    end

    def with_sick_leave_condition
      return unless filters[:with_sick_leave]

      table[:sick_leave_id].not_eq(nil)
    end
  end
end
