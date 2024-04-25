# README

## Introduction

C-Company Activity tracker is a tracker to help assist leaderhsip with assigning activities to members and being able to view the completion of them. In this application, all key leadership will be able to create activities as well as update the leadership structure of their company, such as organizing members within their platoons). On top of that, platoon leaders (which aren't considered key leadership) are also able to manage members within their platoons. We have enabled seeing analytics on activities based on the type it is assigned to.

## Requirements

This code has been run and tested on:

- Ruby - 3.1.2p20
- Rails - 7.0.8
- Ruby Gems - Listed in `Gemfile`
- PostgreSQL - 13.7
- Nodejs - v16.15.0
- Yarn - 1.22.18
- Docker (Latest Container)


## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Download latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation

Download this code repository by using git:

`git clone https://github.com/shaham-noorani/c-company-431.git'

Once cloned, cd into the repository and run:

```
bundle install
rails db:create
```

You will also need to ask us for the .env file which stores our google oauth credentials. Once you have created the .env file with the variables CLIENT_ID and CLIENT_SECRET, you can run the application with:

```
rails server --binding=0.0.0.0
```

## Tests

An RSpec test suite is available and can be run using:

`rspec`

This will run all test cases. If you want to run a specific suite you can run:

```
rspec spec/<suite_name>
```

## Execute Code

Run the following code in Powershell if using windows or the terminal using Linux/Mac


`docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`


Install the app

`bundle install && rails webpacker:install && rails db:create && db:migrate`


Run the app
`rails s -b 0.0.0.0`


The application can be seen using a browser and navigating to http://localhost:3000/


## Environmental Variables/Files

We have environment variables setup for Authentication. Please ask one of us for the .env file.


## Deployment

We used heroku to deploy. You can deploy to heroku by creating a new app using the rails deployment. You must then add the postgresql service to the app. 
## CI/CD

CI/CD has been implemented with github actions. You can see our workflow.yml for more details. 

## Support

We have a support document here:

https://docs.google.com/document/d/1SPtSgvS5s5EuBI3sFjTddylYHvMouWH7FYdX-AMtA0I/edit#heading=h.lwvof6wvy3kw
## Extra help

You can look at the help page on the website at https://ccompany-4098253e3a14.herokuapp.com/

## References

https://www.youtube.com/watch?v=dQw4w9WgXcQ 

heroku.com

github.com

guides.rubyonrails.org