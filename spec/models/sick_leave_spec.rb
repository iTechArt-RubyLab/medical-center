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
#  patient_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_sick_leaves_on_patient_id  (patient_id)
#  index_sick_leaves_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SickLeave, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
