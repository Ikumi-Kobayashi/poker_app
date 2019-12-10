module V1
  class CheckApi < Grape::API

    include PokerCheckService
    include Entity::V1

    format :json

    params do
      requires :cards, type: Array
    end

    resources :check_api do
      post '/' do
        cards = params[:cards]
        error_messages = []
        results = []
        strong_numbers = []
        card_array = []
        cards.each do |card|
          check_service = PokerCheckService.new(card)
          @error_message = check_service.valid?
          card_array.push(card)
          if @error_message.present?
            error_messages.push(@error_message)
            results.push(nil )
            strong_numbers.push(10 )
          else
            error_messages.push(nil)
            judge_service = PokerCheckService.new(card)
            @result = judge_service.result
            @strong_number = judge_service.strong
            results.push(@result)
            strong_numbers.push(@strong_number)
          end
        end

        #最強カードを決める

        api_result = {}
        api_result[:result] = []
        api_result[:error] = []
        card_array.zip(error_messages, results, strong_numbers) do |card, error_message, result, s|
          if s == strong_numbers.min
            best = "true"
          else
            best = "false"
          end
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