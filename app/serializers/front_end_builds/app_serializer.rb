module FrontEndBuilds
  class AppSerializer < ActiveModel::Serializer
    embed :ids, include: true

    attributes :id, :name, :api_key
  end
end
