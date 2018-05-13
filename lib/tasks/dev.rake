namespace :dev do

  task fake_user: :environment do

    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.co",
        password: "12345678",
        description: FFaker::Lorem::sentence(30),
        avatar: file,
        role_id: 1
      )

      user.save!
      puts user.name
    end
  end

  task fake_posts: :environment do
    Post.destroy_all
      User.all.each do |user|
        n = rand(2..9)
        c = [[1,2],[2,3],[1,2,3]]
        n.times do |i|
          np = rand(1..3)
          s = ["Publish", "Draft"] 
          sn = rand(1..2)
          file = File.open("#{Rails.root}/public/image/p#{i+1}.jpg")
          npost = user.posts.create!(
            content: FFaker::Lorem.sentence(50),
            title: FFaker::Lorem.sentence(6),
            authority: "1",
            situation: s[sn-1],
            image: file
            )
          npost.category_ids = c[np-1]
          npost.save
        end
      end

      puts "now you have #{Post.count} post data"
  end  

  task fake_replies: :environment do
    Reply.destroy_all
      Post.all.each do |post|
        if post.situation == "Publish"
          n = rand(2..9)
          n.times do |i|
            post.replies.create!(
              content: FFaker::Lorem.sentence,
              user: User.all.sample
              )
          end
        end
      end

      puts "now you have #{Reply.count} reply data"
  end  

  task count_in: :environment do
    Post.all.each do |post|
      post.viewed_count = 10
      post.save
        
    end
  end

end