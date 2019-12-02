module V1
  class Check_Api < Grape::API

    include PokerCheckService
    include Entity::V1::ResponseEntity

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

        #最強カードを決める
        strong_number_array.each do |s|
          if s == strong_number_array.min
            best = "true"
          else
            best = "false"
          end
        end

        api_result = {}
        api_result[:result] = []
        api_result[:error] = []
        card_array.zip(error_message_array, result_array) do |card, error_message, result|
          if error_message.present?
            api_result[:error].push(
                {
                    "card": card,
                    "msg": error_message
                })
          else result.present?
             api_result[:result].push(
                {
                    "card": card,
                    "hand": result,
                    "best": best
                }
             )
          end
        end
        present api_result, with: ResponseEntity
      end
    end
  end
end