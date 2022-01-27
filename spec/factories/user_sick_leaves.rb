# == Schema Information
#
# Table name: user_sick_leaves
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  sick_leave_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_user_sick_leaves_on_sick_leave_id  (sick_leave_id)
#  index_user_sick_leaves_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (sick_leave_id => sick_leaves.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_sick_leave do
    association :user
    association :sick_leave
  end
end
