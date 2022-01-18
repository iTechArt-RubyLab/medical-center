class VisitsDiagnosis < ApplicationRecord
  belongs_to :diagnosis
  belongs_to :visit
end
