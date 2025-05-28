# Scheduled Tweets

A simple Ruby on Rails app that uses X (formerly Twitter)'s API v2 to schedule tweets.

## Setup
1. You would need to clone the repo. Create an app in X's developer portal, get & store the value of API_Key and API_Key_Secret, will be required ahead.

``` 
# for dev environemnt
rails credentials:edit --environment development

#or
# for production
rails credentials:edit --environment production
```
Add values as 

```
twitter:
    api_key: API_Key_value
    api_secret: API_Key_Secret_value
```

2. Run the app:
 ```
 rails server
 ```

## Future scope:
- When the server stops, all the active jobs for the scheduled tweets are lost. Use Sidekiq for background jobs to publish tweets.
- Email notifications for users about the status of their scheduled tweets (whether posted/failed).
