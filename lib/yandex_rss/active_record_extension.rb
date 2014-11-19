module ActiveRecordExtension

  # Your code goes here...
  extend ActiveSupport::Concern

  # add your instance methods here
  #
  #

  # add your static(class) methods here
  module ClassMethods
    def yandex_rss(hsh)
      YandexRss.config = hsh
      YandexRss.resource = self
    end

    def posts_for_yandex_rss
      res = []
      YandexRss.resource.limit(YandexRss.total).map do |post|
        subres = {}
        YandexRss.rss_structure.each do |attr, inner_attrs|
          if attr==:attributes
            inner_attrs.each do |inner_attr|
              existing_attr = YandexRss.config[:attributes][inner_attr]
              subres[inner_attr] = existing_attr.presence&&post.respond_to?(existing_attr) ? post.send(existing_attr) : ''
            end
          else
            collection_method = YandexRss.config[attr][:collection_method]
            if collection_method.presence&&post.respond_to?(collection_method)
              subres[attr] ||= []
              with_attributes = []
              post.send(YandexRss.config[attr][:collection_method]).to_a.each do |item|
                inner_attrs.each do |inner_attr|
                  with_attributes << YandexRss.config[attr][:collection_items_methods][inner_attr].presence
                end
                subres[attr] << item.attributes.slice(*(with_attributes.compact))
              end
            end
          end
        end
        res << subres
      end
      res
    end
  end

end
