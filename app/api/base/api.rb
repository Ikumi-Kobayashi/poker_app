module Base
  class API < Grape::API
    # あとあと↓のようにしてAPIをマウントするが、今はV1::Rootが無いのでコメントアウトしておく。
    mount V1::Root_Api
  end
end