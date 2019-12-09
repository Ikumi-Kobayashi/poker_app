require 'rails_helper'

include V1

#不正なURLの時
RSpec.describe Check_Api, type: :request do
  describe 'ステータスコード' do
   it '404ページを読み込む(URLがおかしい)' do
     post '/api/v1/posts'
     expect(response.status).to eq(404)
   end
   it '400ページを読み込む（post形式がおかしい）' do
     valid_params = { cards: '{ "cards": [ "D1 D3 D4 D5 D6", "H5 H6 H7 H8 H1", "S1 D1 C1 H1 D' }
     post '/v1/check_api', params: { post: valid_params }
     expect(response.status).to eq(400)
   end
  end

end
# 不正なリクエストの時
