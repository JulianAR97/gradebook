## Introduction
The purpose of this project is to allow users to keep track of their school grades, but more importantly, to demonstrate a fundamental understanding of using the Sinatra web development framework. 

## How to use
1. Fork this repository
2. Delete Gemfile.lock
3. Enter 'bundle install' into terminal
4. Migrate, and seed database
    a. If using zsh, you can simply type ./db_setup into terminal and it should automatically run the migrations and seed the database.
    b. Otherwise enter the following into terminal:
        rake db:migrate
        rake db:seed
5. Enter 'shotgun' into terminal
6. Navigate to 127.0.0.1:9393
