require 'rails_helper'



#こんな感じでうまく動いてるから、後はどんな例で試すか決めて書いていくだけ！
RSpec.describe PokerCheckService do
  describe '#error' do
    it 'カードが0個のとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("")
      expect(poker_check_service.error).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    end
    it 'カードが1〜４個のとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S12")
      expect(poker_check_service.error).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    end
    it 'カードが５個以上のとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 S2 S3 S4 S5 S6")
      expect(poker_check_service.error).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    end
    it '半角スペースで区切ってないとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1S2S3S4S5")
      expect(poker_check_service.error).to eq "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
    end
    it '数字が1~13の整数じゃないとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 S2 S3 S4 S14")
      expect(poker_check_service.error).to eq "5番目のカードの数字が不正です。(S14)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it 'スートがS,D,H,C以外のとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 S2 S3 J4 D4")
      expect(poker_check_service.error).to eq "4番目のカードのスートが不正です。(J4)半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
    end
    it 'カードが重複しているとき' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 S2 S3 D4 D4")
      expect(poker_check_service.error).to eq "カードが重複しています。"
    end

  end
  describe '#result' do
    it 'ストレートフラッシュ' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 S2 S3 S4 S5")
      expect(poker_check_service.result).to eq "ストレートフラッシュ"
    end
    it 'ストレートフラッシュ' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D10 D12 D13 D11 D1")
      expect(poker_check_service.result).to eq "ストレートフラッシュ"
    end
    it 'ストレート' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S10 H12 H13 D11 S1")
      expect(poker_check_service.result).to eq "ストレート"
    end
    it 'ストレート' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S1 D2 D3 D5 C4")
      expect(poker_check_service.result).to eq "ストレート"
    end
    it 'フラッシュ' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 D12 D3 D11 D1")
      expect(poker_check_service.result).to eq "フラッシュ"
    end
    it 'フラッシュ' do
      poker_check_service = PokerCheckService::PokerCheckService.new("S2 S12 S13 S11 S1")
      expect(poker_check_service.result).to eq "フラッシュ"
    end
    it 'フォーオブカインド' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D10 S10 C10 H10 D1")
      expect(poker_check_service.result).to eq "フォーオブアカインド"
    end
    it 'フォーオブカインド' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D1 S1 C1 H1 H13")
      expect(poker_check_service.result).to eq "フォーオブアカインド"
    end
    it 'フルハウス' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D10 S10 H10 D1 D1")
      expect(poker_check_service.result).to eq "フルハウス"
    end
    it 'フルハウス' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H7 C7 S11 D11")
      expect(poker_check_service.result).to eq "フルハウス"
    end
    it 'ツーペア' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H7 S2 S11 D11")
      expect(poker_check_service.result).to eq "ツーペア"
    end
    it 'ツーペア' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H7 C11 S11 D1")
      expect(poker_check_service.result).to eq "ツーペア"
    end
    it 'ワンペア' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H7 C2 S11 D1")
      expect(poker_check_service.result).to eq "ワンペア"
    end
    it 'ワンペア' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H3 C3 S11 D1")
      expect(poker_check_service.result).to eq "ワンペア"
    end
    it 'ハイカード' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H3 C4 S11 D1")
      expect(poker_check_service.result).to eq "ハイカード"
    end
    it 'ハイカード' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 H8 D9 C11 S12")
      expect(poker_check_service.result).to eq "ハイカード"
    end
    it 'ハイカード' do
      poker_check_service = PokerCheckService::PokerCheckService.new("D7 D3 D6 D11 C1")
      expect(poker_check_service.result).to eq "ハイカード"
    end



  end

end

