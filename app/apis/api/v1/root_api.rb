module V1
  class RootApi < Grape::API
    version :v1
    format :json

    mount V1::CheckApi
  end
end