class PokerController < ApplicationController

  include PokerCheckService

  def top
    render "check"
  end

  def check
    check_service = PokerCheckService.new(params[:cards])
    @error_message = check_service.valid?
      if @error_message.nil?
         judge_service = PokerCheckService.new(params[:cards])
         @result = judge_service.judge
         @cards = params[:cards]
      end
  end

end