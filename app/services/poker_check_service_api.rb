module PokerCheckServiceApi

  class PokerCheckServiceApi


    def initialize(card)
      @cards = card
      @card = @cards.split(" ")
    end


    def error
      #カードが５個未満
      if @card[0] == nil or @card[1] == nil or @card[2] == nil or @card[3] == nil or @card[4] == nil
        @error_message = "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
        #カードが５個より多い
      elsif @card.count > 5
        @error_message = "5つのカード指定文字を半角スペース区切りで入力してください。（例：S1 H3 D9 C13 S11）"
        #スートがS,D,H,C以外 数字が1~13以外 おかしい場所も指定する
      elsif @card.count == 5
        suits = [ @card[0][0] , @card[1][0] , @card[2][0] , @card[3][0] , @card[4][0] ]
        numbers = [ @card[0][1,2].to_i , @card[1][1,2].to_i , @card[2][1,2].to_i , @card[3][1,2].to_i , @card[4][1,2].to_i ]
        if suits.grep(/[^SDHC]/).present?
          @temp_message_s = ""
          suits.each_with_index do |s,inx_s|
            if s != "H" && s != "D" && s != "C" && s != "S"
              @temp_message_s += "#{inx_s + 1}番目のカードのスートが不正です。(#{@card[inx_s]})"
              @error_message_s = @temp_message_s + "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
            end
          end
        end
        if numbers.select{ |n| n != 1 && n != 2 && n != 3 && n != 4 && n != 5 && n != 6 && n != 7 && n != 8 && n != 9 && n != 10 && n != 11 && n != 12 && n != 13 }.present?
          @temp_message_n = ""
          numbers.each_with_index do |n,inx_n|
            if n != 1 && n != 2 && n != 3 && n != 4 && n != 5 && n != 6 && n != 7 && n != 8 && n != 9 && n != 10 && n != 11 && n != 12 && n != 13
              @temp_message_n += "#{inx_n + 1}番目のカードの数字が不正です。(#{@card[inx_n]})"
              @error_message_n = @temp_message_n + "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
            end
          end
        end
        if @temp_message_s.present? && @temp_message_n.present?
          @error_message = @temp_message_s + @temp_message_n + "半角英字大文字のスート（S,H,D,C）と数字（1〜13）の組み合わせでカードを指定してください。"
        elsif @temp_message_s.present? && @temp_message_n.blank?
          @error_message = @error_message_s
        else @temp_message_s.blank? && @temp_message_n.present?
        @error_message = @error_message_n
        end
        #カードの重複
        if @card.count - @card.uniq.count > 0
          @error_message = "カードが重複しています。"
        end
      end
      @error_message
    end

    def result
      #変数定義
      suits = [ @card[0][0] , @card[1][0] , @card[2][0] , @card[3][0] , @card[4][0] ]
      numbers = [ @card[0][1,2].to_i , @card[1][1,2].to_i , @card[2][1,2].to_i , @card[3][1,2].to_i , @card[4][1,2].to_i ]
      numbers_sort = numbers.sort
      #ストレートフラッシュのロジック
      if numbers_sort[4] == numbers_sort[3] + 1 &&
          numbers_sort[3] == numbers_sort[2] + 1 &&
          numbers_sort[2] == numbers_sort[1] + 1 &&
          numbers_sort[1] == numbers_sort[0] + 1 &&
          suits[0] == suits[1] && suits[1] == suits[2] && suits[2] == suits[3] && suits[3] == suits[4]
        @result = "ストレートフラッシュ"
      elsif numbers_sort == [1,10,11,12,13] &&
          suits[0] == suits[1] && suits[1] == suits[2] && suits[2] == suits[3] && suits[3] == suits[4]
        @result = "ストレートフラッシュ"
        #ストレートのロジック
      elsif numbers_sort[4] == numbers_sort[3] + 1 &&
          numbers_sort[3] == numbers_sort[2] + 1 &&
          numbers_sort[2] == numbers_sort[1] + 1 &&
          numbers_sort[1] == numbers_sort[0] + 1
        @result = "ストレート"
      elsif numbers_sort == [1,10,11,12,13]
        @result = "ストレート"
        #フラッシュのロジック
      elsif suits[0] == suits[1] && suits[1] == suits[2] && suits[2] == suits[3] && suits[3] == suits[4]
        @result = "フラッシュ"
        #ペア系
        #フォーオブアカインドのロジック
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[1] == numbers_sort[2] && numbers_sort[2] == numbers_sort[3]
        @result = "フォーオブアカインド"
      elsif numbers_sort[1] == numbers_sort[2] && numbers_sort[2] == numbers_sort[3] && numbers_sort[3] == numbers_sort[4]
        @result = "フォーオブアカインド"
        #フルハウスのメソッド
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[1] == numbers_sort[2] && numbers_sort[3] == numbers_sort[4]
        @result = "フルハウス"
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[2] == numbers_sort[3] && numbers_sort[3] == numbers_sort[4]
        @result = "フルハウス"
        #スリーオブアカインドのロジック
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[1] == numbers_sort[2]
        @result = "スリーオブアカインド"
      elsif numbers_sort[1] == numbers_sort[2] && numbers_sort[2] == numbers_sort[3]
        @result = "スリーオブアカインド"
      elsif numbers_sort[2] == numbers_sort[3] && numbers_sort[3] == numbers_sort[4]
        @result = "スリーオブアカインド"
        #ツーペアのロジック
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[2] == numbers_sort[3]
        @result = "ツーペア"
      elsif numbers_sort[0] == numbers_sort[1] && numbers_sort[3] == numbers_sort[4]
        @result = "ツーペア"
      elsif numbers_sort[1] == numbers_sort[2] && numbers_sort[3] == numbers_sort[4]
        @result = "ツーペア"
        #ワンペアのロジック
      elsif numbers_sort[0] == numbers_sort[1]
        @result = "ワンペア"
      elsif numbers_sort[1] == numbers_sort[2]
        @result = "ワンペア"
      elsif numbers_sort[2] == numbers_sort[3]
        @result = "ワンペア"
      elsif numbers_sort[3] == numbers_sort[4]
        @result = "ワンペア"
        #ハイカードのロジック
      else
        @result = "ハイカード"
      end
      @result
    end

    def strong
      if  @result == "ストレートフラッシュ"
        @strong_number = 1
      elsif  @result == "フォーオブアカインド"
        @strong_number = 2
      elsif @result == "フルハウス"
        @strong_number = 3
      elsif @result == "フラッシュ"
        @strong_number = 4
      elsif @result == "ストレート"
        @strong_number = 5
      elsif @result == "スリーオブアカインド"
        @strong_number = 6
      elsif @result == "ツーペア"
        @strong_number = 7
      elsif @result == "ワンペア"
        @strong_number = 8
      else @result == "ハイカード"
        @strong_number = 9
      end
      @strong_number
    end

  end

end
