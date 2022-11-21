# README
This is echo server implemted to create mock endpoints.

## how to run:
- clone this repo

#### run on local machine: 
1- run `bundle install`<br>
2- run `rails db:migrate`<br>
3- run `rails s` -> it will start on port 3000<br>

#### run using docker: 
1- build the docker image by running : `docker build -t echo-server .`<br>
2- run it using : `docker run -d -p 3000:3000 echo-server`<br>

#### run the tests:
1- run `rails db:migrate RAILS_ENV=test`<br>
2- run `rspec`<br>
