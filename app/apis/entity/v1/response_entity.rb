module Entity
  module V1
    class ResponseEntity < Grape::Entity
     expose :result, using: Entity::V1::ResultEntity
     expose :error, using: Entity::V1::ErrorEntity
    end
  end
end