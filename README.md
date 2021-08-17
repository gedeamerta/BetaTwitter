<h1>Final Project Generasi Gigih (Beta Twitter)</h1>
<p> Welcome to Generasi Gigih Social Media Platform for Final Project </p>

## Build With
- Ruby
- Sinatra
- Mysql2

## Install Ruby
Before start to run this project you need to have ruby first
Dependency|Access Link
--------------|--------------
Rbenv (Install Ruby with Rbenv)| https://github.com/rbenv/rbenv#choosing-the-ruby-version, https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-18-04

## Gem Install
Then install `gem` dependencies.

Mysql 
````
gem install mysql2
````
Sinatra
````
gem install sinatra
````
Rspec
````
gem install rspec
````

## Import Database
Create your database and then import the database.
````
CREATE DATABASE newdatabase;

mysql -u [username] -p newdatabase < beta_twitter.sql
````

## Run App
Run application after install all of dependencies and database already import it.
````
ruby main.rb
````

<h1> Database Schema </h1>
![schema_db](https://user-images.githubusercontent.com/45842303/129661013-b6c2bc7e-cba6-44a5-830d-2782761951ce.jpg)
