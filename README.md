### To set up the project

It assumes you have running:

* ruby 2.x.x (it works from 2.0.0 to 2.1.5)

```
git clone git@github.com:furilo/trackdons.git
cd trackdons
bundle install
rake db:setup
cp config/secrets.yml.example config/secrets.yml
rails server
```

Then navigate to: http://localhost:3000


### To work on a new feature / bug / improvement

Create a branch and pull request.

* Have a local copy of the repo
* Create a new branch for your work (git checkout -b new-feature)
* Commit your changes (git commit -am 'Description of the commits')
* Push to the branch (git push origin new-feature)
* Create a new Pull Request


### Libraries/gems being used (see Gemfile for complete reference):

* http://plugins.adchsm.me/slidebars
* https://github.com/onomojo/i18n_country_select
* https://github.com/onomojo/i18n-country-translations
