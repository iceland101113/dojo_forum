# Category
Category.destroy_all

category_list = [
  { name: "求職相關" },
  { name: "程式語言" },
  { name: "心情分享" }, 
  { name: "美食探索" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"


# Default admin
User.create(email: "admin@example.com", password: "12345678", role: "admin")
puts "Default admin created!"