module FactoryHelpers

  def create_user
    User.create!( :email => "test@example.com", :password => "12345678")
  end

  def create_topic
    Topic.create!( :subject => "FOOBAR")
  end

end
