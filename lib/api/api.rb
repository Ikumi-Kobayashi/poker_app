class API < Grape::API
  prefix "api"
  format :json
  mount Document_API
        ...#以下作成するAPIを追記
end