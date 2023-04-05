class Category < ApplicationRecord
  belongs_to :user

  validates :name, :user, presence: true

end
