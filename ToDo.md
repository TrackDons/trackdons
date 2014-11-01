http://guides.rubyonrails.org/getting_started.html#rendering-a-partial-form
https://www.railstutorial.org/book/_single-page#sec-method_definitions
https://github.com/peterwillcn/rails4-autocomplete

### Specific ToDos

- [ ] Intercionalización https://github.com/hexorx/countries
- 


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

add_index :users, :email, unique: true



 Quantity
	Currency
	Date
	Comment
	Tag