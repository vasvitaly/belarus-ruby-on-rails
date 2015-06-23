# Belarus Ruby User Group

Belarusian Ruby User Group - Ruby-developer community, created for the exchange of ideas and experiences. We are also interested in the development of Ruby in our country and help each other to build a successful IT-career.

## Development

To run application on your local:

    mailcatcher -ip=0.0.0.0
    rake sunspot:solr:start
    rails s
    rake jobs:work

You might need to install java:

    apt-get update
    apt-get upgrade
    apt-get install python-software-properties
    add-apt-repository ppa:ferramroberto/java
    apt-get update
    apt-get install sun-java6-jre sun-java6-plugin

### Tests

Standard RSpec tests are used for testing the application. At first, start solr:

    RAILS_ENV=test rake sunspot:solr:start

The tests can be run with:

    bundle exec rake spec

or simple `rspec spec`.

## Contribution

 + Fork the project.
 + Make your feature addition or bug fix.
 + Add tests for it.
 + Send a pull request.




#mysqldump -udeploy -pra1ls1nbelarus --default-character-set=utf8 BelarusRubyOnRails_production > brug_dump_2015_06_12.sql
#scp deploy@brug.by:/home/deploy/dumps/brug_dump_2015_06_12.sql brug_dump_2015_06_12.sql