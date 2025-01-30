class User < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :interests, through: :user_interests
  has_many :skills, through: :user_skills

  validates :email, uniqueness: { case_sensitive: false }

  enum :gender, { male: 0, female: 1 }

  def full_name
    "#{surname} #{name} #{patronymic}"
  end
end
