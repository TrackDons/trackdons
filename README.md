![](https://travis-ci.org/TrackDons/trackdons.svg)

TrackDons is a simple tool to keep track of the projects you have donated to. It lets remind you which projects
have you donated to and when (and if you should donate again), and it encourages you to share the donations
you have made as a way of inspiring your friends to donate to this or other projects in need.

You can start tracking your donations at [trackdons.org](http://www.trackdons.org) - and learn more about it in the [About page](http://trackdons.org/en/about).

## Contributing

This is an open project, so any contribution is welcome. Take a look go the [Wiki](https://github.com/TrackDons/trackdons/wiki) to start contributing.

### To set up the project

It assumes you have running:

* ruby 2.x.x (it works from 2.0.0 to 2.1.5)

```
git clone git@github.com:TrackDons/trackdons.git
cd trackdons
bundle install
rake db:setup
cp config/secrets.yml.example config/secrets.yml
cp config/database.yml.example config/database.yml
rails server
```

Then navigate to: http://localhost:3000

### To work on a new feature / bug / improvement

* [Fork the project](https://help.github.com/articles/fork-a-repo)
* Clone down your fork
* Create a feature branch for your work (`git checkout -b new-feature`)
* Commit your changes (`git commit -am 'Description of the commits'`)
* Push the branch up to your fork
* Send a pull request for your branch

### Libraries/gems being used

See Gemfile for complete reference
