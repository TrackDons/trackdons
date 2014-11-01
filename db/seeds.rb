# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Álvaro Ortiz",
             email: "alvaro@furilo.com",
             password:              "alvaro",
             password_confirmation: "alvaro",
             admin: true)
User.create!(name:  "Pedro Ximenez",
             email: "pedro@furilo.com",
             password:              "alvaro",
             password_confirmation: "alvaro",
             admin: true)


50.times do |n|
  name  = 'Name Surname'
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

projects = Project.create([
	{ id: 1, name: 'Wikipedia', url: 'http://www.wikipedia.com', twitter: 'wikipedia', description: 'This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia.', donation_url: 'https://donate.wikimedia.org/wiki/Special:FundraiserLandingPage'}, 
	{ id: 2, name: 'ACNUR España', url: 'http://www.acnur.es', twitter: 'ACNURspain', description: 'ACNUR es la agencia española para los refugiados. Dependiente de la ONU', donation_url: 'https://www.eacnur.org/ayuda-ong-africa-donativos-hacerse-socio#_ga=1.240044163.1046714309.1413590594'  }, 
	{ id: 3, name: 'My fantastic organization', url: 'http://www.mysteryworld.es', twitter: 'FantasticOrg', description: 'Mi descripción no puede dejar de ser fantástica'  },
	{ id: 4, name: 'My Wadus ONG', url: 'http://www.mywadus.es', twitter: 'WadusONG', description: 'ONG description ONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG description'  }
])
Donation.create(quantity: '10', currency: '€', date: '2014-10-14', project_id: 1, user_id: 1)
Donation.create(quantity: '20', currency: '€', date: '2014-08-08', project_id: 1, user_id: 2)
Donation.create(quantity: '100', currency: '€', date: '2014-10-14', project_id: 2, user_id: 3)
Donation.create(quantity: '220', currency: '€', date: '2014-08-08', project_id: 2, user_id: 4)
Donation.create(quantity: '10', currency: '€', date: '2014-10-14', project_id: 3, user_id: 5)
Donation.create(quantity: '20', currency: '€', date: '2014-08-08', project_id: 3, user_id: 6)
Donation.create(quantity: '100', currency: '€', date: '2014-10-14', project_id: 4, user_id: 7)
Donation.create(quantity: '220', currency: '€', date: '2014-08-08', project_id: 4, user_id: 8)

