module Entity
  module V1
    class ErrorEntity < Grape::Entity
      expose :card
      expose :msg
    end
  end
end