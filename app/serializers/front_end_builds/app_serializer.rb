module FrontEndBuilds
  class AppSerializer < ActiveModel::Serializer
    embed :ids, include: true
    self.root = true

    attributes :id, :name, :api_key
  end
end
