# SPRITLE HIRE

Tool to simplify the hiring process and save valuable time by choosing the right candidates, manage talent pool, strengthen team collaboration, and hire top talent. Make recruitment and talent management your competitive advantages with the best Applicant Tracking System.

## Requirements

- Ruby 2.7.1
- Rails 7.0.0
- Postgres 12+

## App setup instructions

1. #### Clone the app

&emsp;&emsp;`git clone git@github.com:spritlesoftware/spritle-hire.git && cd spritle-hire`

2. #### Install dependencies

&emsp;&emsp;`npm install`

&emsp;&emsp;`yarn install`

&emsp;&emsp;`bundle install`

3. #### Copy config files

&emsp;&emsp;`cp .env.example .env`

&emsp;&emsp;`cp config/database.yml.example config/database.yml`

4. #### Create the Database

&emsp;&emsp;`rake db:create`

5. #### Migrate the databse schema

&emsp;&emsp;`rake db:migrate`

6. #### Populate seed data

&emsp;&emsp;`rake db:seed`

7. #### Populate questions and candidates data

&emsp;&emsp;`rake load_questions:data -> Populate Questions data`

&emsp;&emsp;`rake load_candidates:data -> Populate Candidates data`

8. #### Start the server

&emsp;&emsp;`rails s`
