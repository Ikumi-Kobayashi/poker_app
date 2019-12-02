module Entity
  module V1
    class ResultEntity < Grape::Entity
      expose :card
      expose :hand
      expose :best
    end
  end
end