class User < ApplicationRecord
  has_many :user_interests
  has_may :user_skils
  has_many :interest, through: :user_interests
  has_may :skils, through: :user_skils

  enum :gender, { unknown: 0, male: 1, female: 2 }, default: 1
end
