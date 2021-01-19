# README


![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange) ![](https://img.shields.io/badge/Code-HTML-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://travis-ci.com/Relocate08/Relocate08-Front-End-Rails.svg?branch=main)

# Sweater Weather

## Learning Goals
  * Expose an API that aggregates data from multiple external APIs
  * Expose an API that requires an authentication token
  * Expose an API for CRUD functionality
  * Determine completion criteria based on the needs of other developers
  * Research, select, and consume an API based on your needs as a developer
  
## Overview

This repo represents the backend Api, that was need for the frontend to get the information they need, Module 3.  

Sweather Weather, is an app that allows you to look up information for a trip you are planning to go on. It will give you many types of information such as the travel time, the city you are leaving and the city were your going, and the weather of that city your heading to. By login in we will give you your own Api key that will allow you to use our services.

## Table of Contents
  - [Design](#design)
  - [Setup](#setup)
  - [Running the Tests](#running-the-tests)
  - [Deployment](#deployment)
  - [Authors](#authors)

### Design
  * This project is calling 3 diffrent Api's which are the MapQuest’s Geocoding API , OpenWeather One Call API, Pexels API, to allow us to give you all the information you need in order to give you information about the trip you will take. 
  * In our database we only have one table in order to keep your information safe from harm.

### Setup
#### Prerequisites
These setup instructions are for Mac OS.

This project requires the use of `Ruby 2.5.3` and `Rails 5.2.4.3`.
We also use `PostgreSQL` as our database.

##### Install Necessary Programs

1. Verify your machine has the correct version of Ruby installed (2.5.3).  You can check this by entering `ruby -v` from the command line.
    - To install, enter `rbenv install 2.5.3` from the command line.   

2. Verify your machine has the correct version of Rails installed (5.2.4.3).  You can check this by entering `rails -v` from the command line.
    - To install, enter `gem install rails -v 5.2.3` from the command line.
    
3. Sign in to get [MapQuest’s Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/) key

4. Sign in to get [OpenWeather One Call API](https://openweathermap.org/api/one-call-api) key

5. Sign in to get [OpenWeather One Call API](https://www.pexels.com/api/) key

##### Local Repo Setup
1. Fork & Clone Repo
2. Run `bundle install`.
3. Setup database: `rails db:create`.

##### Authorizing Application
1. Run `bundle exec figaro install` to set up the `application.yml` file to hide your sensitive credentials.
2. Add your credentials to `application.yml` as environment variables:
```
WEATHER_API_KEY: < Add your weather api key >
MAP_API_KEY: < Add your mapquest api key >
IMAGE_API_KEY: < Add your pixels api key >
```

#### Running the Tests
From the command line, within the project's directory, run `bundle exec rspec`.  You should see all passing tests.



### Forcast Requests:
```
GET '/api/v1/forecast'
```

```
Example Response for `GET 'forecast?location=denver,co'`
```

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather_data": {
                "datetime": "2021-01-19T16:30:08.000-05:00",
                "sunrise": "2021-01-19T09:17:07.000-05:00",
                "sunset": "2021-01-19T19:04:03.000-05:00",
                "temp": 37.98,
                "feels_like": 31.23,
                "humidity": 34,
                "uvi": 0.59,
                "visibility": 10000,
                "conditions": "broken clouds",
                "icon": "04d"
            },
            "daily_weather_data": [
                {
                    "date": "2021-1-19",
                    "sunrise": "2021-01-19T09:17:07.000-05:00",
                    "sunset": "2021-01-19T19:04:03.000-05:00",
                    "max_temp": 37.98,
                    "min_temp": 28.22,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2021-1-20",
                    "sunrise": "2021-01-20T09:16:35.000-05:00",
                    "sunset": "2021-01-20T19:05:12.000-05:00",
                    "max_temp": 51.15,
                    "min_temp": 32.04,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-1-21",
                    "sunrise": "2021-01-21T09:16:00.000-05:00",
                    "sunset": "2021-01-21T19:06:21.000-05:00",
                    "max_temp": 45.52,
                    "min_temp": 34.05,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2021-1-22",
                    "sunrise": "2021-01-22T09:15:24.000-05:00",
                    "sunset": "2021-01-22T19:07:31.000-05:00",
                    "max_temp": 41.52,
                    "min_temp": 30.96,
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "date": "2021-1-23",
                    "sunrise": "2021-01-23T09:14:45.000-05:00",
                    "sunset": "2021-01-23T19:08:41.000-05:00",
                    "max_temp": 48.9,
                    "min_temp": 31.53,
                    "conditions": "light snow",
                    "icon": "13d"
                }
            ],
            "hourly_weather_data": [
                {
                    "time": "16-00-00",
                    "temperature": 37.98,
                    "wind_speed": "4.54",
                    "wind_direction": "ESE",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "17-00-00",
                    "temperature": 37.06,
                    "wind_speed": "3.98",
                    "wind_direction": "E",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "18-00-00",
                    "temperature": 36.5,
                    "wind_speed": "1.66",
                    "wind_direction": "ENE",
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "time": "19-00-00",
                    "temperature": 34.9,
                    "wind_speed": "0.98",
                    "wind_direction": "NNW",
                    "conditions": "scattered clouds",
                    "icon": "03d"
                },
                {
                    "time": "20-00-00",
                    "temperature": 33.82,
                    "wind_speed": "0.47",
                    "wind_direction": "NW",
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "21-00-00",
                    "temperature": 32.99,
                    "wind_speed": "1.83",
                    "wind_direction": "NE",
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "22-00-00",
                    "temperature": 32.47,
                    "wind_speed": "1.19",
                    "wind_direction": "WSW",
                    "conditions": "clear sky",
                    "icon": "01n"
                },
                {
                    "time": "23-00-00",
                    "temperature": 32.09,
                    "wind_speed": "0.81",
                    "wind_direction": "WSW",
                    "conditions": "clear sky",
                    "icon": "01n"
                }
            ]
        }
    }
}
```

### Background Image
```
GET '/api/v1/backgrounds'
```
Example Response for `GET 'backgrounds?location=denver,c'`
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "denver, co",
                "image_url": "https://images.pexels.com/photos/3744162/pexels-photo-3744162.jpeg",
                "credits": {
                    "source": "https://www.pexels.com",
                    "logo": "https://images.pexels.com/lib/api/pexels-white.png",
                    "author": "Brady Knoll",
                    "author_url": "https://www.pexels.com/@trvlust",
                    "original_image_post": "https://www.pexels.com/photo/tall-palm-trees-under-purple-sky-3744162/"
                }
            }
        }
    }
}
```

### Create User
```
POST /api/v1/users
This will need to be send in JSON Formant, In order to do this you will have to go to Postman change to Post, add your local url, then click on body and select raw, to the right you should see a drop down that says text, change that for JSOn and your all set.
```
Example Response for `{ 
                  "email": "whatever123@example.com",
                  "password": "password",
                  "password_confirmation": "password"
    }'`
```
{
    "data": {
        "id": "302",
        "type": "users",
        "attributes": {
            "email": "whatever123@example.com",
            "api_key": "7bd4806f-54eb-4f12-b770-f6dfdf0947cb"
        }
    }
}
```

### User Login
```
POST /api/v1/sessions
This will need to be send in JSON Formant, In order to do this you will have to go to Postman change to Post, add your local url, then click on body and select raw, to the right you should see a drop down that says text, change that for JSOn and your all set.
```
Example Response for `{ 
                  "email": "whatever123@example.com",
                  "password": "password"
    }'`
```
{
    "data": {
        "id": "302",
        "type": "users",
        "attributes": {
            "email": "whatever123@example.com",
            "api_key": "7bd4806f-54eb-4f12-b770-f6dfdf0947cb"
        }
    }
}
```

### Road Trip
```
POST /api/v1/road_trip
This will need to be send in JSON Formant, In order to do this you will have to go to Postman change to Post, add your local url, then click on body and select raw, to the right you should see a drop down that says text, change that for JSOn and your all set.
```
Example Response for `{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "7bd4806f-54eb-4f12-b770-f6dfdf0947cb"
}'`
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "1h50m",
            "weather_at_eta": {
                "temperature": 49.44,
                "conditions": "clear sky"
            }
        }
    }
}
```

## Testing
![Screen Shot 2021-01-19 at 4 44 00 PM](https://user-images.githubusercontent.com/61892154/105096775-973d9100-5a75-11eb-8609-863aaf382a39.png)

## Schema
![Screen Shot 2021-01-19 at 4 47 18 PM](https://user-images.githubusercontent.com/61892154/105097076-02876300-5a76-11eb-803b-e99b40ba6a1c.png)
