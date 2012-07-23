namespace :db do
  desc "Fill db with sample data"
  task populate: :environment do
    admin = User.create!(
      first_name: "Fake",
      last_name: "User",
      email: "fake@email.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
    admin.toggle!(:admin)
    
    99.times do |n|
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "fake-#{n+1}@email.com"
      password = "password"
      User.create!(
        first_name:   first_name,
        last_name:    last_name,
        email:        email,
        password:     password,
        password_confirmation: password
      )
    end
    
    users = User.all(limit: 6)
    5.times do
      users.each {|user| user.reviews.create!(name: user.name, status: "active")}
    end
  end
end
      