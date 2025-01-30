class Users::Create < ActiveInteraction::Base
  string :name
  string :patronymic
  string :surname
  string :email
  string :age
  string :nationality
  string :country
  integer :gender
  array :interests, default: []
  array :skills, default: []

  validates :name, presence: true
  validates :patronymic, presence: true
  validates :surname, presence: true
  validates :email, presence: true, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/i }
  validates :age, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :nationality, presence: true
  validates :country, presence: true
  validates :gender, presence: true, inclusion: { in: User.genders.values }

  def to_model
    User.new
  end

  def execute
    user = User.new(inputs.except(:interests, :skills))
    ActiveRecord::Base.transaction do
      unless user.save
        errors.merge!(user.errors)
        return
      end

      interests = Interest.where(id: inputs[:interests])
      user.interests = interests

      skills = Skill.where(id: inputs[:skills])
      user.skills = skills
    end

    user
  end
end
