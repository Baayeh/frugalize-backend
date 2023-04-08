class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :name, :amount, :category_id, presence: true

  def json_format
    {
      id: self.id,
      name: self.name,
      amount: self.amount,
      category: self.category.name,
      cat_image: self.category.image_url,
      created_at: self.created_at
    }
  end

  def self.total_expenses
    sum(:amount)
  end
end
