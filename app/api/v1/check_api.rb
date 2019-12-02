module V1
  class Check_Api < Grape::API

    include PokerCheckService
    format :json

    params do
      requires :cards, type: Array
    end

    resources :check_api do
      post '/' do
        cards = params[:cards]
        error_message_array = []
        result_array = []
        strong_number_array = []
        card_array = []
        cards.each do |card|
          check_service = PokerCheckService.new(card)
          @error_message = check_service.error
          card_array.push(card)
          if @error_message.present?
            error_message_array.push(@error_message)
            result_array.push(nil )
            strong_number_array.push(10 )
          else
            error_message_array.push(nil)
            judge_service = PokerCheckService.new(card)
            @result = judge_service.result
            @strong_number = judge_service.strong
            result_array.push(@result)
            strong_number_array.push(@strong_number)
          end
        end

#全部の手札がエラーの時 エラーもあるしresultもある　全部の手札がresultの時  zipメソッドめちゃくちゃ便利(インデックス番号を合わせたら)
        api_result = {}
        api_result[:result] = []
        api_result[:error] = []

        card_array.zip(error_message_array, result_array, strong_number_array) do |card, error_message, result, s|
          if s == strong_number_array.min
            best = "true"
          else
            best = "false"
          end
          #エラーだけの時
          if error_message.present? && result.blank?
            api_result[:error].push(
                {
                    "card": card,
                    "msg": error_message
                }
            )
            #エラーも結果も両方ある時
          elsif error_message.present? && result.present?
            api_result[:result].push(
                {
                    "card": card,
                    "hand": result,
                    "best": best
                }
            )
            api_result[:error].push(
                {
                    "card": card,
                    "msg": error_message
                }
            )
            #結果だけある時
          else error_message.blank? && result.present?

          api_result[:result].push(
              {
                  "card": card,
                  "hand": result,
                  "best": best
              }
          )
          end

        end
        api_result
      end
    end
  end
end