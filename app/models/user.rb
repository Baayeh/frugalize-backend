class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  has_many :categories, dependent: :destroy
  has_many :expenses, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, :username, :email, :password, :income, presence: true
  validates :username, uniqueness: { case_sensitive: false }

  def jwt_payload
    super
  end
end