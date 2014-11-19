Rails.application.routes.draw do
  get '/yandex_rss' => 'yandex_rss/rss_items#index'
end
