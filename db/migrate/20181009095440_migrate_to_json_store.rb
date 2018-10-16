class MigrateToJsonStore < ActiveRecord::Migration[5.1]
  def up
    drop_table :category_translations
    add_column :categories, :name_translations, :jsonb

    categories_data = [
      { en: 'Animals', es: 'Animales'},
      { en: 'Arts and Culture', es: 'Arte y Cultura'},
      { en: 'Children', es: 'Infancia'},
      { en: 'Climate Change', es: 'Cambio Climático'},
      { en: 'Democracy and Governance', es: 'Democracia y Gobierno'},
      { en: 'Disaster Recovery', es: 'Catástrofes'},
      { en: 'Economic Development', es: 'Desarrollo Económico'},
      { en: 'Education', es: 'Educación'},
      { en: 'Environment', es: 'Medio Ambiente'},
      { en: 'Health', es: 'Salud'},
      { en: 'Human Rights', es: 'Derechos Humanos'},
      { en: 'Humanitarian Assistance', es: 'Asistencia Humanitaria'},
      { en: 'Hunger', es: 'Hambre'},
      { en: 'Microfinance', es: 'Microfinanciación'},
      { en: 'Sport', es: 'Deporte'},
      { en: 'Technology', es: 'Tecnología'},
      { en: 'Women and Girls', es: 'Mujeres y Niñas'}
    ]

    categories_data.each do |t|
      category = Category.find_by! name: t[:en]
      category.name_translations = t
      category.save!
    end

    remove_column :categories, :name
  end

  def down
    create_table :category_translations do |t|
      t.timestamps
    end
    add_column :categories, :name, :string
    remove_column :categories, :name_translations
  end
end
