<h1>Final Project Generasi Gigih (Beta Twitter)</h1>
<p> Welcome to Generasi Gigih Social Media Platform for Final Project </p>

## Problem Description
This app was created for social media development. It can be used by all developers who want to improve their algorithm about Social Media platform. So it's created personally for developers only. 

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

Changes your database connection 
````
    connect = Mysql2::Client.new(
        :host => "your_host",
        :username => "your_username",
        :password => "your_password",
        :database => "beta_twitter"
    )
````

## Run App
Run application after install all of dependencies and database already import it.
````
ruby main.rb
````

# Database Schema
![schema_db](https://user-images.githubusercontent.com/45842303/129661900-b2a24660-96a0-44c3-9580-f654357fd8df.jpg)
