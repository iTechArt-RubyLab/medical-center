class SickLeave < ApplicationRecord
  has_many :visits, dependent: :nullify
end
