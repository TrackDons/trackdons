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
             country: 'ES',
             admin: true)
User.create!(name:  "Pedro Ximenez",
             email: "pedro@furilo.com",
             password:              "alvaro",
             password_confirmation: "alvaro",
             country: 'US',
             admin: true)


50.times do |n|
  name  = 'Name Surname'
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               country: 'GB',
               password_confirmation: password)
end

categories = Category.create([
  {  name: 'Animals' },
  {  name: 'Arts and Culture' },
  {  name: 'Children' },
  {  name: 'Climate Change' },
  {  name: 'Democracy and Governance' },
  {  name: 'Disaster Recovery' },
  {  name: 'Economic Development' },
  {  name: 'Education' },
  {  name: 'Environment' },
  {  name: 'Health' },
  {  name: 'Human Rights' },
  {  name: 'Humanitarian Assistance' },
  {  name: 'Hunger' },
  {  name: 'Microfinance' },
  {  name: 'Sport' },
  {  name: 'Technology' },
  {  name: 'Women and Girls' }
])

[
  { 'Animals' => 'Animales'},
  { 'Arts and Culture' => 'Arte y Cultura'},
  { 'Children' => 'Infancia'},
  { 'Climate Change' => 'Cambio Climático'},
  { 'Democracy and Governance' => 'Democracia y Gobierno'},
  { 'Disaster Recovery' => 'Catástrofes'},
  { 'Economic Development' => 'Desarrollo Económico'},
  { 'Education' => 'Educación'},
  { 'Environment' => 'Medio Ambiente'},
  { 'Health' => 'Salud'},
  { 'Human Rights' => 'Derechos Humanos'},
  { 'Humanitarian Assistance' => 'Asistencia Humanitaria'},
  { 'Hunger' => 'Hambre'},
  { 'Microfinance' => 'Microfinanciación'},
  { 'Sport' => 'Deporte'},
  { 'Technology' => 'Tecnología'},
  { 'Women and Girls' => 'Mujeres y Niñas'}
].each do |names|
  names = names.to_a.first

  c = Category.find_by_slug names.first.parameterize
  puts "Not found: #{names.first} - #{names.first.parameterize}" if c.nil?
  I18n.locale = :en
  c.name = names.first
  I18n.locale = :es
  c.name = names.last
  c.save!
end

projects = Project.create([
  { name: 'Wikipedia', category: Category.find_by_slug('health'), url: 'http://www.wikipedia.com', twitter: 'wikipedia', description: 'This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia. This is the description of the wikipedia.', donation_url: 'https://donate.wikimedia.org/wiki/Special:FundraiserLandingPage'},
  { name: 'ACNUR España', category: Category.find_by_slug('hunger'), url: 'http://www.acnur.es', twitter: 'ACNURspain', description: 'ACNUR es la agencia española para los refugiados. Dependiente de la ONU', donation_url: 'https://www.eacnur.org/ayuda-ong-africa-donativos-hacerse-socio#_ga=1.240044163.1046714309.1413590594', :countries => ['ES']  },
  { name: 'My fantastic organization', category: Category.find_by_slug('technology'), url: 'http://www.mysteryworld.es', twitter: 'FantasticOrg', description: 'Mi descripción no puede dejar de ser fantástica', :countries => ['ES', 'US', 'UK']  },
  { name: 'My Wadus ONG', category: Category.find_by_slug('health'), url: 'http://www.mywadus.es', twitter: 'WadusONG', description: 'ONG description ONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG descriptionONG description'  },
  { name: 'Electronic Frontier Foundation', category: Category.find_by_slug('children'), url: 'http://www.eff.org', twitter: 'EFF', description: 'The Electronic Frontier Foundation is the leading nonprofit organization defending civil liberties in the digital world. Founded in 1990, EFF champions user privacy, free expression, and innovation through impact litigation, policy analysis, grassroots activism, and technology development. We work to ensure that rights and freedoms are enhanced and protected as our use of technology grows.', donation_url: 'https://supporters.eff.org/donate', :countries => ['US']  },
  { name: 'CIC - Centro de Integración Ciudadana Monterrey', category: Category.find_by_slug('climate-change'), url: 'http://www.cic.mx', twitter: 'cicmty', description: 'El CIC es una red de confianza 100% ciudadana que enlaza e integra al ciudadano y las autoridades por medio de espacios claros, confiables y auténticos de participación en temas que impactan a la sociedad, buscando despertar las conciencias y activar a los ciudadanos a trabajar en suma para mejorar nuestra sociedad. Estos espacios se fundamentan en el aprovechamiento de nuevas tecnologías como las redes sociales y nuestra plataforma Tehuan.', donation_url: 'http://www.cic.mx/?p=2166'},
  { name: 'Mozilla - Firefox', category: Category.find_by_slug('climate-change'), url: 'http://www.mozilla.org', twitter: 'mozilla', description: "We're a global community dedicated to making the web better and more open for all. Join us to imagine, build & teach the web's future.", donation_url: 'https://sendto.mozilla.org'}
])
Donation.create(quantity_cents: '1000', currency: 'EUR', date: '2014-10-14', project: projects[0], user: User.all[0], comment: 'Wadus comment', quantity_privacy: 0)
Donation.create(quantity_cents: '2000', currency: 'EUR', date: '2014-08-08', project: projects[0], user: User.all[0], comment: 'Wadus comment', quantity_privacy: 1)
Donation.create(quantity_cents: '10000', currency: 'EUR', date: '2014-10-14', project: projects[1], user: User.all[1], comment: 'Wadus comment', quantity_privacy: 0)
Donation.create(quantity_cents: '22000', currency: 'EUR', date: '2014-08-08', project: projects[1], user: User.all[2], comment: 'Wadus comment', quantity_privacy: 1)
Donation.create(quantity_cents: '1000', currency: 'EUR', date: '2014-10-14', project: projects[2], user: User.all[3], comment: 'Wadus comment', quantity_privacy: 0)
Donation.create(quantity_cents: '2000', currency: 'EUR', date: '2014-08-08', project: projects[2], user: User.all[4], comment: 'Wadus comment', quantity_privacy: 1)
Donation.create(quantity_cents: '10000', currency: 'EUR', date: '2014-10-14', project: projects[3], user: User.all[5], comment: 'Wadus comment', quantity_privacy: 0)
Donation.create(quantity_cents: '22000', currency: 'EUR', date: '2014-08-08', project: projects[3], user: User.all[5], comment: 'Wadus comment', quantity_privacy: 1)
Donation.create(quantity_cents: '2500', currency: 'USD', date: '2014-10-14', project: projects[4], user: User.all[0], comment: 'You should donate too!', quantity_privacy: 0)
Donation.create(quantity_cents: '2500', currency: 'EUR', date: '2014-08-08', project: projects[4], user: User.all[1], comment: 'Fighting for privacy in the Internet', quantity_privacy: 1)
Donation.create(quantity_cents: '5000', currency: 'EUR', date: '2004-10-10', project: projects[6], user: User.all[0], comment: "Rewind to early 2000's. Chrome didn't exist. Internet Explorer had +90% of browser market share. A free software project to create an alternative browser emerged: Firefox. It slowly started to get supporters while developing a great product. An advocacy campaign was created at spreadfirefox.com. And a crazy idea was proposed: a full page ad in the New York Times crowdfunded with donations to promote the 1.0 version of Firefox. It just happened. A double page ad with more than 10.000 names of the donors in it.

  Read more at: https://blog.mozilla.org/press/2004/12/mozilla-foundation-places-two-page-advocacy-ad-in-the-new-york-times/

  http://tech.slashdot.org/story/04/10/19/1338254/firefox-seeks-full-page-ad-in-new-york-times")
