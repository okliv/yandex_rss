xml.instruct! :xml, :version => '1.0'#, encoding: 'windows-1251'
xml.rss :version => '2.0', 'xmlns:yandex' => 'http://news.yandex.ru', 'xmlns:media' => 'http://search.yahoo.com/mrss/' do

  xml.channel do
    xml.title @channel[:title]
    xml.link @channel[:link]
    xml.description @channel[:description]
    xml.image do
      xml.url @channel[:image][:url]
      xml.title @channel[:image][:title]
      xml.link @channel[:image][:link]
    end
    for post in @posts
      xml.item do
        xml.title post[:title]
        xml.link post[:link]
        xml.pdalink post[:pdalink]
        xml.description post[:description]
        xml.author post[:author]
        xml.category post[:category]
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
