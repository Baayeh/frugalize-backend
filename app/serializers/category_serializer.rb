class CategorySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :image, :created_at, :updated_at, :image_url
end
