json.array!(@posts) do |post|
  json.extract! post, :id, :timestr
  json.url post_url(post, format: :json)
end
