namespace :dev do
  task :fake => :environment do
    Topic.delete_all
    
    100.times do
      Topic.create!( :subject => Faker::Lorem.sentence,
                     :content => Faker::Lorem.paragraph )
    end

  end
end
