# == Schema Information
#
# Table name: sick_leaves
#
#  id          :bigint           not null, primary key
#  destination :string
#  ended_at    :datetime         not null
#  started_at  :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class SickLeave < ApplicationRecord
  has_many :visits, dependent: :nullify

  validates :started_at, :destination, :ended_at, presence: true
end
