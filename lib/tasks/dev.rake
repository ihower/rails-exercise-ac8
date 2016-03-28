namespace :dev do
  task :fake => :environment do
    Topic.delete_all

    users = []
    10.times do
      users << User.create!( :email => Faker::Internet.email, :password => "12345678" )
    end

    100.times do
      Topic.create!( :subject => Faker::Lorem.sentence,
                     :content => Faker::Lorem.paragraph,
                     :user => users.sample )
    end

  end
end
