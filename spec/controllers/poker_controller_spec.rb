require 'rails_helper'

  include PokerCheckService

RSpec.describe PokerController, type: :controller do
  describe 'controller全般' do
    it '正常に動作しているかどうか' do
      expect(response.status).to eq(200)
    end
  end
  describe '#check' do
    #@cards,@result,@error_messageがきちんとしていればビューには表示され、@result,@error_messageはサービスのテストで立証済み @cardsを正しく拾ってこれてるかをチェックすればOK！
    it 'ビューに対してきちんと返せているか' do
      post :check
      c = PokerCheckService::PokerCheckService.new("S1 S2 S3 S4 S5")
      expect(assigns(:cards)).to eq c
    end

  end

end
