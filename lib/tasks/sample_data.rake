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
    users.each do |user|
      # Pending
      created = Date.today
      status_date = Date.today
      duration = 14
      user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "pending", status_dt: status_date, duration: duration, created_at: created)
      
      # Active
      created = Date.today - 9.days
      status_date = Date.today - 6.days
      user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "active", status_dt: status_date, duration: duration, created_at: created)
      
      # Completed
      created = status_date = 1.year.ago
      user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "completed", status_dt: status_date, duration: duration, created_at: created)
      
      # Completed
      created = status_date = 2.years.ago
      user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "expired", status_dt: status_date, duration: duration, created_at: created)

    end 
  end
end
      