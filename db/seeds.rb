# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
[ "skill 1", "skill 2", "skill 3" ].each do |skill|
  Skill.create!(name: skill)
end

[ "interest 1", "interest 2", "interest 3" ].each do |interest|
  Interest.create!(name: interest)
end
