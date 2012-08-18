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
      User.create!(
        first_name:   first_name,
        last_name:    last_name,
        email:        email,
        password:     "foobar",
        password_confirmation: "foobar"
      )
    end
    
    users = User.all(limit: 6)
    users.each do |user|
      # Pending
      created = Date.today
      status_date = Date.today
      duration = 14
      review = user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "pending", status_dt: status_date, duration: duration, created_at: created)
      review_reviewer = ReviewReviewer.create!(person_id: "99", review_id: review.id, relationship: "manager")
      review_reviewer = ReviewReviewer.create!(person_id: "98", review_id: review.id, relationship: "peer")
      review_reviewer = ReviewReviewer.create!(person_id: "97", review_id: review.id, relationship: "peer")
      
      # Active
      created = Date.today - 9.days
      status_date = Date.today - 6.days
      review = user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "active", status_dt: status_date, duration: duration, created_at: created)
      review_reviewer = ReviewReviewer.create!(person_id: "96", review_id: review.id, relationship: "manager")
      review_reviewer = ReviewReviewer.create!(person_id: "95", review_id: review.id, relationship: "peer")
      review_reviewer = ReviewReviewer.create!(person_id: "94", review_id: review.id, relationship: "peer")
      
      # Completed
      created = status_date = 1.year.ago
      review = user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "completed", status_dt: status_date, duration: duration, created_at: created)
      review_reviewer = ReviewReviewer.create!(person_id: "93", review_id: review.id, relationship: "manager")
      review_reviewer = ReviewReviewer.create!(person_id: "92", review_id: review.id, relationship: "peer")
      review_reviewer = ReviewReviewer.create!(person_id: "91", review_id: review.id, relationship: "peer")
      
      # Completed
      created = status_date = 2.years.ago
      review = user.reviews.create!(name: "#{user.name} review #{created.strftime("%m/%d/%y")}", status: "expired", status_dt: status_date, duration: duration, created_at: created)
      review_reviewer = ReviewReviewer.create!(person_id: "90", review_id: review.id, relationship: "manager")
      review_reviewer = ReviewReviewer.create!(person_id: "89", review_id: review.id, relationship: "peer")
      review_reviewer = ReviewReviewer.create!(person_id: "88", review_id: review.id, relationship: "peer")

    end 
  end
end
      