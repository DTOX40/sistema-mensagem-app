class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role, :status
end
