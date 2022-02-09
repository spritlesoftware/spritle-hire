# SPRITLE HIRE

Tool to simplify the hiring process and save valuable time by choosing the right candidates, manage talent pool, strengthen team collaboration, and hire top talent. Make recruitment and talent management your competitive advantages with the best Applicant Tracking System.

## Short Clips and Screenshots

#### Quick Tour

https://user-images.githubusercontent.com/56751579/149709189-896ca522-c6ab-44eb-a21d-352b34838f0d.mp4

#### Dashboard View

![Dashboard View](https://user-images.githubusercontent.com/56751579/149709440-ac3f87ac-9d20-4804-9a96-7ade268a0438.png)

#### Candidate Directory
To show the list of candidates with their test status and result percentage.

![Candidate Directory](https://user-images.githubusercontent.com/56751579/149709488-bc437f66-4605-41f8-a6d2-2bb03138c30a.png)

#### Import Candidate

![Import Candidate](https://user-images.githubusercontent.com/56751579/149709535-7655213e-13c2-42bc-9957-a2e9a6b3781e.png)

#### List of Questions

![List of Questions](https://user-images.githubusercontent.com/56751579/149709545-9b1955f2-4272-496b-b353-b47557954a78.png)

#### Import Question

![Import Question](https://user-images.githubusercontent.com/56751579/149709559-de79b65d-152f-48bc-b8f1-760cec48998a.png)

#### Login Page

![Login Page](https://user-images.githubusercontent.com/56751579/149709400-ea89c254-eb8c-40cd-a1af-d52007ad90c0.png)

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
