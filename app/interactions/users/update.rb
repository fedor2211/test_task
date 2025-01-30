class Users::Update < ActiveInteraction::Base
  object :user
  string :name, default: nil
  string :patronymic, default: nil
  string :surname, default: nil
  string :email, default: nil
  string :age, default: nil
  string :nationality, default: nil
  string :country, default: nil
  integer :gender, default: nil
  array :interests, default: []
  array :skills, default: []

  validates :user, presence: true
  validates :name, presence: true, unless: -> { name.nil? }
  validates :email, format: { with: /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/i }, unless: -> { email.nil? }
  validates :gender, inclusion: { in: User.genders.values }, unless: -> { gender.nil? }
  validates :patronymic, presence: true, unless: -> { patronymic.nil? }
  validates :surname, presence: true, unless: -> { surname.nil? }
  validates :age, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 90 }, unless: -> { age.nil? }
  validates :nationality, presence: true, unless: -> { nationality.nil? }
  validates :country, presence: true, unless: -> { country.nil? }

  def to_model
    user
  end

  def execute
    ActiveRecord::Base.transaction do
      unless user.update(inputs.except(:interests, :skills, :user).compact)
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
