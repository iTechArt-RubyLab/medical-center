class UserSickLeave < ApplicationRecord
  belongs_to :user
  belongs_to :sick_leave
end
