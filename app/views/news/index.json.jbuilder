json.array!(@news) do |news|
  json.extract! news, :id, :flag, :img, :link, :mainText, :resID, :secSrcA, :sumFrom, :summary, :title, :type
  json.url news_url(news, format: :json)
end
