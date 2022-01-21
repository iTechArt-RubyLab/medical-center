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
#  doctor_id   :integer          not null
#  patient_id  :integer          not null
#
require 'rails_helper'

RSpec.describe SickLeave, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
