### To set up the project

```
git clone the repo
cd trackdons
bundle install
rake db:setup
rails serve
```

i18n is being set up in place, and will be controlled (partially) through subdomains. So you can set up some development hosts:

````
127.0.0.1   en.trackdons.local
127.0.0.1   es.trackdons.local
127.0.0.1   fr.trackdons.local
127.0.0.1   it.trackdons.local
````

Then navigate to: http://en.trackdons.local:3000


### To work on a new feature / bug / improvement

Create a branch and pull request. 

* Have a local copy of the repo
* Create a new branch for your work (git checkout -b new-feature)
* Commit your changes (git commit -am 'Description of the commits')
* Push to the branch (git push origin new-feature)
* Create a new Pull Request


### Libraries being used: 

* http://plugins.adchsm.me/slidebars

### Software versions

* Rails 4.1.6
* ruby 2.0.0p247

