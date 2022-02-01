# == Schema Information
#
# Table name: visits
#
#  id            :bigint           not null, primary key
#  cabinet       :string           not null
#  date          :datetime         not null
#  notes         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  patient_id    :bigint           not null
#  sick_leave_id :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_visits_on_patient_id     (patient_id)
#  index_visits_on_sick_leave_id  (sick_leave_id)
#  index_visits_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (patient_id => patients.id)
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Visit, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
