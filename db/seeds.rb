require 'rake'

Rake::Task['db:truncate_all'].invoke

FactoryBot.create(:diagnosis, :tuberculosis)
FactoryBot.create(:diagnosis, :bronchitis)
FactoryBot.create(:diagnosis, :tonsillitis)

FactoryBot.create(:allergy, :sweets)
FactoryBot.create(:allergy, :citrus)
FactoryBot.create(:allergy, :pollen)

FactoryBot.create(:category, :dentist)
FactoryBot.create(:category, :ophthalmologist)
FactoryBot.create(:category, :pediatrician)

3.times { FactoryBot.create(:patient) }

3.times { FactoryBot.create(:user) }

FactoryBot.create(:sick_leave)

FactoryBot.create(:visit)
