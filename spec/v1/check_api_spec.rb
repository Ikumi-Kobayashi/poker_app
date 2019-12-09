require 'rails_helper'

include V1

#poker_check_service.rbでサービスがうまく機能していることは確認済み

RSpec.describe Check, type: :request do
  describe 'error_message_arrayの中身' do
    it '２個あった時にちゃんと配列になってるか' do
      error_message_array = []
      error_message_array.push("5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）")
      error_message_array.push("カードが重複しています。")
      expect(error_message_array).to eq ["5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）", "カードが重複しています。"]
    end
  end
  describe 'result_arrayの中身' do
    it '２個あった時にちゃんと配列になってるか' do
      result_array = []
      result_array.push("ストレートフラッシュ")
      result_array.push("フルハウス")
      expect(result_array).to eq ["ストレートフラッシュ", "フルハウス"]
    end
  end
  describe 'card_arrayの中身' do
    it '3個あった時(nil含む)にちゃんと配列になってるか' do
      card_array = []
      card_array.push("S2 S3 S4 S5 S6")
      card_array.push("C3 C6 C1 C9 C12")
      card_array.push(nil )
      expect(card_array).to eq ["S2 S3 S4 S5 S6", "C3 C6 C1 C9 C12", nil]
    end
  end
end
