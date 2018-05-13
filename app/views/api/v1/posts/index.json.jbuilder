json.data do
  json.array! @posts do |post|
    json.(post, :id, :title, :content, :user_id, :image)
  end
end