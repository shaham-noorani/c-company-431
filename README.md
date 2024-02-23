# README

## Introduction

C-Company Activity tracker is a tracker to help assist leaderhsip with assigning activities to members and being able to view the completion of them. In this application, all key leadership will be able to create activities as well as update the leadership structure of their company, such as organizing members within their platoons). On top of that, platoon leaders (which aren't considered key leadership) are also able to manage members within their platoons. We have enabled seeing analytics on activities based on the type it is assigned to. 

## Requirements

This code has been run and tested on:

- Ruby - 3.0.2p107
- Rails - 6.1.4.1
- Ruby Gems - Listed in `Gemfile`
- PostgreSQL - 13.3
- Nodejs - v16.9.1
- Yarn - 1.22.11
- Docker (Latest Container)


## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/

## Installation

Download this code repository by using git:

`git clone https://github.com/CSCE431-Software-Engineering/sprint-1-ccompany'
## Tests

An RSpec test suite is available and can be ran using:

`rspec spec/`

You can run all the test cases by running. This will run both the unit and integration tests.
`rspec .`

## Execute Code

Run the following code in Powershell if using windows or the terminal using Linux/Mac


`docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`


Install the app

`bundle install && rails webpacker:install && rails db:create && db:migrate`


Run the app
`rails server --binding:0.0.0.0`


The application can be seen using a browser and navigating to http://localhost:3000/


## Environmental Variables/Files

We have environment variables setup for Authentication. Please ask one of us for the .env file.


## Deployment

We used heroku to deploy. You can deploy to heroku by creating a new app using the rails deployment. You must then add the postgresql service to the app. 
## CI/CD

CI/CD has been implemented with github actions. You can see our workflow.yml for more details. 

## Support

Please reach out to keeganasmith2003@gmail.com for help. 