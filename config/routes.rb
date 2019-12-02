Rails.application.routes.draw do
  get '/' => "poker#top"
  post "poker/check" => "poker#check"
  get 'poker/check' => 'poker#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Base::API => '/'
end

