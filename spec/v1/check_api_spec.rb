require 'rails_helper'

include V1

#poker_check_service.rbでサービスがうまく機能していることは確認済み

RSpec.describe Check, type: :request do
  describe 'error_message_arrayの中身' do
    it '２個あった時にちゃんと配列になってるか' do
      error_messages = []
      error_messages.push("5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）")
      error_messages.push("カードが重複しています。")
      expect(error_messages).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）", "カードが重複しています。"]
    end
  end
  describe 'result_arrayの中身' do
    it '２個あった時にちゃんと配列になってるか' do
      results = []
      results.push("ストレートフラッシュ")
      results.push("フルハウス")
      expect(results).to eq ["ストレートフラッシュ", "フルハウス"]
    end
  end
  describe 'card_arrayの中身' do
    it '3個あった時(nil含む)にちゃんと配列になってるか' do
      cards = []
      cards.push("S2 S3 S4 S5 S6")
      cards.push("C3 C6 C1 C9 C12")
      cards.push(nil )
      expect(cards).to eq ["S2 S3 S4 S5 S6", "C3 C6 C1 C9 C12", nil]
    end
  end
end
