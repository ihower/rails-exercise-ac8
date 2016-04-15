namespace :dev do

  task :ubike => :environment do

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"

    json_string = RestClient.get(url)

    data = JSON.parse( json_string )

    data["result"]["results"].each do |u|
      existing = Ubike.find_by_raw_id( u["_id"] )
      if existing
        # update
      else
        Ubike.create( :raw_id => u["_id"], :name => u["sna"])
        puts "create #{u["sna"]}"
      end
    end

  end

  task :fake_products => :environment do
    Product.delete_all
    100.times do
      p = Product.create!( :name => Faker::Lorem.word, :description => Faker::Lorem.paragraph, :price => (rand(100) + 1) * 100 )
      puts "Create product #{p.id}"
    end
  end

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
