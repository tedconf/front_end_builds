module FrontEndBuilds
  class AppSerializer < ActiveModel::Serializer
    attributes :id, :name, :api_key
  end
end
