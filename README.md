# README
## Notification Service 

##### Setup
- `git clone git@github.com:pantaubersama/Notification.git`
- setup your database (postgresql)
- create env variable files (.env.development , .env.test)
    - `.env.development`
```
    API_DEBUGGING="true"
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=notification_staging
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME=localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
    
    # API Doc setting
    DOC_USERNAME="admin"
    DOC_PASSWORD="admin"
```

 - `.env.test` 
```
    API_DEBUGGING="true"
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=notification_test
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME=localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
    
    # API Doc setting
    DOC_USERNAME="admin"
    DOC_PASSWORD="admin"
```
   
- `$ bundle install`
- `$ rails db:create db:migrate`
- `$ rails s`
- go to [`http://localhost:3000/doc`](http://localhost:3000/doc)

#### HTTP Authentication

Check it out in your `.env.development`

```
Username : admin
Password : admin
```
