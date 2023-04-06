class Category < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :name, :user, :image, :cat_budget, presence: true
  validates :name, uniqueness: true

  def image_url
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
