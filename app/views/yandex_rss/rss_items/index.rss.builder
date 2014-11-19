xml.instruct! :xml, :version => '1.0', encoding: 'windows-1251'
xml.rss :version => '2.0', 'xmlns:yandex' => 'http://news.yandex.ru', 'xmlns:media' => 'http://search.yahoo.com/mrss/' do
  # xml.channel do
  #   xml.title "News"
  #   xml.description "Description"
  #   xml.link "/news"
  #
  #   for post in @posts
  #     xml.item do
  #       xml.title post.title
  #       xml.description post.content
  #       xml.pubDate post.date_posted.to_s(:rfc822)
  #       xml.link "/news/#{post.reference}"
  #       xml.guid "/news/#{post.reference}"
  #       xml.icon "/favicon.ico"
  #     end
  #   end
  # end
  #
  xml.channel do
    xml.title @channel[:title] #'Российские новости'
    xml.link @channel[:link] #'http://www.rossiyskie-novosti.ru'
    xml.description @channel[:description] #'Ежедневная иллюстрированная московская общественно-политическая газета.xml./description>'
    xml.image do
      xml.url @channel[:image][:url] #'http://www.rossiyskie-novosti.ru/logo.gifxml./url>'
      xml.title @channel[:image][:title] #'>Российские новостиxml./title>'
      xml.link @channel[:image][:link] #'http://www.rossiyskie-novosti.ru/xml./link>'
    end
    for post in @posts
      xml.item do
        xml.title post[:title] #'>Яндекс ищет на президентском сайтеxml./title>'
        xml.link post[:link] #'>http://www.rossiyskie-novosti.ru/2003/03/25/yandex.htmlxml./link>'
        xml.pdalink post[:pdalink] #'http://www.m.rossiyskie-novosti.ru/2003/03/25/yandex.htmlxml./pdalink>'
        xml.description post[:description] #'Программный продукт Яndex.Site установлен на официальном сайте президента Россииxml./description>'
        xml.author post[:author] #'Иван Петровxml./author>'
        xml.category post[:category] #'Технологииxml./category>'
        for asset in post[:assets]
          type = asset[:video] ? 'video/x-ms-asf' : 'image/jpeg'
          xml.enclosure url: asset[:url], type: type
        end
        xml.pubDate post[:pub_date] #'Sun, 29 Sep 2002 19:59:01 +0400'
        xml.send('yandex:genre', post[:genre])
        xml.send('yandex:full-text', post[:full_text])
        # xml.send('yandex:online', post.online)
        if post[:related_posts].to_a.size>0
          xml.send('yandex:related') do
            for related_post in post[:related_posts]
              xml.link(url: related_post[:url]) { related_post[:name] }
            end
          end
        end
      end
    end
  end

end
