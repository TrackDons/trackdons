### Specific ToDos

- [ ] Intercionalización https://github.com/hexorx/countries 

### General ToDos

- [ ] Autenticación
- [ ] Intercionalización https://github.com/hexorx/countries
- [ ] Validaciones
  - [ ] Proyectos
  - [ ] Usuarios
  - [ ] Donaciones

 - [ ] Proyectos
   - [ ] Editar / Borrar
   - [ ] Añadir categoria
   - [ ] Trackear los outbound links en botón de Donar + con GAnalytics
   - [ ] Control if you are creating a duplicated project (ie. search first for projects with that name; "You mean...")
   - [ ] Make the friendly_id for duplicated slugs shorter

- [ ] Donaciones
  - [ ] Gema Currencies? https://github.com/RubyMoney/money-rails
  - [ ] Tags en vista: f.input :tag_list

- [ ] Users
  - [ ] Esconder el ID usuario / mostrar username instead
  
bin/rails generate model Donation quantity:decimal currency:string date:date comment:text tags:string project:references

rails generate model User name:string email:string password_digest:string 
rails generate model Invitation invitation_token:string invited_email:string used:boolean user:references 

add_index :users, :email, unique: true

 Quantity
	Currency
	Date
	Comment
	Tag



## oAuth login

Cases:

- Sign up with email, comes to login with Twitter
  - Creates user, ask for email

- Sign up with email, comes to login with Facebook
  - We match emails; ask for password confirmation

- Sign up with Twitter
  - Asks for email (and optional: password) √

## Category for projects

- maquetación
- modelo 
- editar proyecto
- listado de proyectos por categoria
- filtro de proyectos
- incluir categoria al añadir proyecto
