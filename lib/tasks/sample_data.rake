namespace :db do
	desc "Fill database with sample data" 
	task populate: :environment do

		###
		# an admin user
		admin = User.create!(	name: "Example User",
													email: "example@railstutorial.org",
													password: "foobar",
													password_confirmation: "foobar")
		admin.toggle!(:admin)		
		
		###
		# 99 more users (without being admin)
		99.times do |n|
			name  = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org" 
			password = "password"
			User.create!(	name: name,
				email: email,
				password: password,
				password_confirmation: password)
		end

		###
		# 50 microposts on each 6 first users
		users = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5) # returns "lorem ipsum"
			users.each { |user| user.microposts.create!(content: content) }
		end
	end
end