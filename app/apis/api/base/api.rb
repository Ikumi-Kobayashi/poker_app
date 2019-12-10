module Base
  class API < Grape::API
    rescue_from Grape::Exceptions::Base do
      error!({error: "400 Bad Request：不正なリクエストです"}, 400)
    end

    #404の時（URLの形がおかしい　”不正なURLです。”）
    route :any, '*path' do
      error!({error: "404 Not Found：不正なURLです。"}, 404)
    end

    #500の時（それ以外のエラー全部”予期しないエラーです”）
    rescue_from Exception do
      error!({error: "500 Internal Server Error：予期しないエラーです"}, 500)
    end
    mount V1::RootApi
  end
end