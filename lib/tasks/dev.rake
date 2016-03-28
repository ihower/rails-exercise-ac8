namespace :dev do
  task :fake => :environment do
    Topic.delete_all
    Comment.delete_all

    users = []
    10.times do
      users << User.create!( :email => Faker::Internet.email, :password => "12345678" )
    end

    100.times do
      t = Topic.create!( :subject => Faker::Lorem.sentence,
                     :content => Faker::Lorem.paragraph,
                     :user => users.sample  )

      (5 + rand(10)).times do
        t.comments.create!( :content => Faker::Lorem.sentence,
                            :user => users.sample )
      end
    end

  end
end
