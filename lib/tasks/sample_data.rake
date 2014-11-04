namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    100.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   image: 'マリオ.jpg',
                   password: password,
                   password_confirmation: password)
    end
  end
end