require 'yandex_rss/version'
require 'yandex_rss/railtie' if defined?(Rails)
require 'yandex_rss/active_record_extension'
require 'yandex_rss/engine'

module YandexRss
  include ActiveRecordExtension
  mattr_accessor :config
  mattr_accessor :resource

  TOTAL = 20
  MAX_TOTAL = 100

  def self.rss_structure
    {attributes: [:title, :link, :pdalink, :description, :author, :category, :pub_date, :genre, :full_text],
     assets: [:url, :is_video],
     related: [:url, :name]
    }
  end

  def self.channel
    config[:channel]
  end

  def self.total
    config[:total].to_i<MAX_TOTAL&&config[:total].to_i>0 ? config[:total].to_i : TOTAL
  end

  def self.posts
    self.resource.posts_for_yandex_rss
  end

end
