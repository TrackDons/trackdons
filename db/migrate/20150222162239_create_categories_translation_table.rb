class CreateCategoriesTranslationTable < ActiveRecord::Migration
  def up
    Category.create_translation_table!({
      :name => :string,
    }, {
      :migrate_data => true
    })

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

  end

  def down
    Category.drop_translation_table! :migrate_data => true
  end
end
