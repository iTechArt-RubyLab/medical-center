# == Schema Information
#
# Table name: allergies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_allergies_on_name  (name) UNIQUE
#
class Allergy < ApplicationRecord
  has_many :patient_allergies, dependent: :destroy
  has_many :patients, through: :patient_allergies

  validates :name, presence: true, length: { in: 3..50 }, uniqueness: true
end
