class CategorySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :cat_budget, :image, :created_at, :updated_at, :image_url, :cat_total_expenses
end
