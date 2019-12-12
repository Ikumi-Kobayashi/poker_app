module V1
  class RootApi < Grape::API
    version :v1, using: :path
    format :json

    mount V1::CheckApi
  end
end