# == Schema Information
#
# Table name: visits_diagnoses
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  diagnosis_id :bigint
#  visit_id     :bigint
#
# Indexes
#
#  index_visits_diagnoses_on_diagnosis_id  (diagnosis_id)
#  index_visits_diagnoses_on_visit_id      (visit_id)
#
require 'rails_helper'

RSpec.describe VisitsDiagnosis, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
