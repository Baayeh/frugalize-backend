class AddCatBudgetToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :cat_budget, :decimal, precision: 10, scale: 2
  end
end
