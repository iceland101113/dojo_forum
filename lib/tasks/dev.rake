namespace :dev do

  task count_in: :environment do
    Post.all.each do |post|
      post.viewed_count = 0
      post.save
        
    end
  end
end