module V1
  class Root_Api < Grape::API
    version :v1
    format :json

    mount V1::Check_Api
  end
end