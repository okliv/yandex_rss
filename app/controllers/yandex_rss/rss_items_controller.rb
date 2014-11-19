module YandexRss
  class RssItemsController < ApplicationController

    layout false

    def index
      @channel = YandexRss.channel
      @posts = YandexRss.posts
      render :template => 'yandex_rss/rss_items/index.rss.builder'
    end
  end
end
