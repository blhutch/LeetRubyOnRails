# LeetRubyOnRails 


1. [USER](#sign-up-login-users-info-and-delete-user)
   - [REGISTER](#new-user-registration)
   - [LOGIN](#user-login)
   - [LIST USERS](#get-all-users)
   - [LIST USER INFO](#get-current-user-info)
   - [DELETE CURRENT USER](#delete-current-user)
2. [LAYOVER](#layover-info)
   - [CREATE A LAYOVER](#create-a-layover)
   - [USER LAYOVERS SHOW](#user-layovers-show)
   - [LAYOVERS FOR A USER](#layovers-for-a-user)
   - [LAYOVER UPDATE](#layover-update)
   - [DELETE A LAYOVER](#delete-a-layover)
3. [FIND A POSSIBLE MEETUP](#find-a-possible-meetup)
  

# API

## Overview

All access is over HTTPS, and access from the "https://leetapp.herokuapp.com/" domain. All data is sent and received as JSON.

## Access Token

Assume that every request requires an access token unless stated otherwise. The access token must be provided in the header.

To do this make sure you set 'Access-Token' equal to the user's access token in every required request.

```
['Access-Token'] = 'f16395873f4bcee7ef5d46e531b9f659'
```

## Sign up, Login, User(s) info and Delete user

### New user registration

Access-Token:

Not required.

Path:

`POST '/users/register'`

Parameters:

| name       | type   | description                              |
|------------|--------|------------------------------------------|
| user_name   | string | username for user to be created          |
| password   | string | password has to be at least 8 characters |
| first_name | string | first name of user to be created         |
| last_name  | string | last name of user to be created          |
| email      | string | email of user to be created              |
```
Upon successful registration, a welcome email will be sent to the user.
```

Example data successful response:

```json
Response Status Code: 201

{
  "user_name": "whatever",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659f16395873f4bcee7ef5d46e531b9f659",
  "first_name": "John",
  "last_name": "Doe",
  "email": "johndoe@gmail.com"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "errors": [
    "Password can't be blank",
    "Email can't be blank",
    "Email is not a valid email.",
    "User name can't be blank",
    "First name can't be blank",
    "Last name can't be blank"
  ]
}

```

### User login

Access-Token:

Not required.

Path:

`POST '/users/login'`

Parameters:

| name     | type   | description                                                 |
|----------|--------|-------------------------------------------------------------|
| user_name | string | username for the user you want get authentication key for   |
| password | string | password for the user you want get authentication token for |

Example data successful response:

```json
Response Status Code: 200

{
  "user_name": "whatever",
  "access_token": "f16395873f4bcee7ef5d46e531b9f659"
}
```

Example data failure response:

```json
Response Status Code: 422

{
  "message":"The username or password you supplied is incorrect."
}
```

### Get all users

Access-Token:

Not required.

Path:

`GET '/users'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| page | integer | defaults to 1, 25 results per page |


Example data successful response:

```json
Response Status Code: 200

[
  {
    "user_name": "rickard",
    "first_name": "rsdffdasdf",
    "last_name": "rsfsdfdfdf",
    "email": "rickard@supsssssssss.com",
    "created_at": "2015-06-19T20:46:47.041Z"
  },
  {
    "user_name": "dsfasdf",
    "first_name": "rsdffdasdf",
    "last_name": "rsfsdfdfdf",
    "email": "whattt@sup.com",
    "created_at": "2015-06-19T15:51:02.488Z"
  }
]
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There are no users to display."
}
```

### Get current user info

Access-Token:

Required.

Path:

`GET '/user'`

Example data successful response:

```json

{
  "user_name": "dsfasdf",
  "first_name": "rsdffdasdf",
  "last_name": "rsfsdfdfdf",
  "email": "whattt@sup.com",
  "created_at": "2015-06-19T15:51:02.488Z"
}
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There are no users to display."
}
```

### Get user by user id

Access-Token: Required

Path:  `GET '/user/:id`

Parameters:

|  name |  type |  description
|-------|-------|-------------------------
|user_id|integer|assigned at registration

Example data successful response:

```json

{
  "user_name": "dsfasdf",
  "first_name": "rsdffdasdf",
  "last_name": "rsfsdfdfdf",
  "email": "whattt@sup.com",
  "created_at": "2015-06-19T15:51:02.488Z"
}
```

Example data failure response:

```json
Response Status Code: 404

{
  "message": "There are no users to display."
}
```


### Delete current user

Access-Token:

Required.

Path:

`DELETE '/user'`

Parameters:

| name | type    | description                        |
|------|---------|------------------------------------|
| password | string | user has to supply password |

Example data successful response:

```json
Response Status Code: 200

{ 
  "message": "User has been deleted" 
}
```

Example data failure response:

```json
Response Status Code: 401

{
  "message": "Access Token not found."
}
```

```json
Response Status Code: 401

{
  "message": "Password you supplied is not correct"
}
```

##Layover info

### Create a Layover

Access-Token:          Required (Current User Logged In)

Path:      `POST '/layovers/create'`

Parameters:

| Name            | Type           | Description
|-----------------|----------------|-------------
|"arrival_time" | "datetime"       | "2015-07-24T13:45:00"
|"dept_time"    | "datetime"       | "2015-07-24T17:00:00" 
|"city"          | "string"        | "Atlanta"
|"short_name" | "string"           | "ATL"
|"display"        | "boolean"      |"true"
```
Upon successful registration, a welcome email will be sent to the user.
```

Example data successful response:
```json
{
  "id": 13,
  "layover_info": {
    "arrival_time": "2015-07-16T12:29:06.000Z",
    "departure_time": "2015-07-16T17:29:06.000Z",
    "city": "Atlanta",
    "airport": "ATL",
    "display_user_info": true,
    "created_at": "2015-07-16T17:04:44.926Z",
    "updated_at": "2015-07-16T17:04:44.926Z"
  },
  "creator": {
    "user_name": "the",
    "first_name": "iron",
    "last_name": "yard",
    "email": "the@iron.yard"
  }
}

Response Status Code: 201 Created
```
##User Layovers Show

Access-Token:          Required(Current User Logged In)

Path:         `GET  '/layovers/user/layover'`

Example data successful response:
```json
[
  {
    "id": 17,
    "layover_info": {
      "arrival_time": "2015-07-25T13:54:00.000Z",
      "departure_time": "2015-07-25T17:13:00.000Z",
      "city": "Ft. Worth",
      "airport": "DFW",
      "display_user_info": true,
      "created_at": "2015-07-16T18:10:32.950Z",
      "updated_at": "2015-07-16T18:10:32.950Z"
    },
    "creator": {
      "user_name": "texas",
      "first_name": "grape",
      "last_name": "vine",
      "email": "texas@grape.vine"
    }
  },
  {
    "id": 15,
    "layover_info": {
      "arrival_time": "2015-07-25T13:00:00.000Z",
      "departure_time": null,
      "city": "Ft. Worth",
      "airport": "DFW",
      "display_user_info": true,
      "created_at": "2015-07-25T17:56:39.143Z",
      "updated_at": "2015-07-25T17:56:39.143Z"
    },
    "creator": {
      "user_name": "texas",
      "first_name": "grape",
      "last_name": "vine",
      "email": "texas@grape.vine"
    }
  }
  ]

Response Status Code: 200 OK
```


##Layovers For A User

Access-Token:          Required(Current User Logged In)

Path:         `GET  '/layovers/user/layovers'`

Example data successful response:
```json
[
  {
    "id": 17,
    "layover_info": {
      "arrival_time": "2015-07-25T13:54:00.000Z",
      "departure_time": "2015-07-25T17:13:00.000Z",
      "city": "Ft. Worth",
      "airport": "DFW",
      "display_user_info": true,
      "created_at": "2015-07-16T18:10:32.950Z",
      "updated_at": "2015-07-16T18:10:32.950Z"
    },
    "creator": {
      "user_name": "texas",
      "first_name": "grape",
      "last_name": "vine",
      "email": "texas@grape.vine"
    }
  },
  {
    "id": 15,
    "layover_info": {
      "arrival_time": "2015-07-25T13:00:00.000Z",
      "departure_time": null,
      "city": "Ft. Worth",
      "airport": "DFW",
      "display_user_info": true,
      "created_at": "2015-07-25T17:56:39.143Z",
      "updated_at": "2015-07-25T17:56:39.143Z"
    },
    "creator": {
      "user_name": "texas",
      "first_name": "grape",
      "last_name": "vine",
      "email": "texas@grape.vine"
    }
  }
  ]

Response Status Code: 200 OK
```


##Layover Update

Access-Token:          Required(Current User Logged In)

Path:         `PUT  '/layovers/:id/update'`

Parameters:

| Name            | Type        | Description
|-----------------|-------------|-------------
| layover id      | integer     |assigned at creation                      

Example data successful response:
```json
 "id": 17,
    "layover_info": {
      "arrival_time": "2015-07-25T14:10:00.000Z",
      "departure_time": "2015-07-25T17:13:00.000Z",
      "city": "Ft. Worth",
      "airport": "DFW",
      "display_user_info": true,
      "created_at": "2015-07-16T18:10:32.950Z",
      "updated_at": "2015-07-16T18:10:32.950Z"
    },
    "creator": {
      "user_name": "texas",
      "first_name": "grape",
      "last_name": "vine",
      "email": "texas@grape.vine"
      
Response Status Code: 200 OK
```
## Delete A Layover

Access-Token:          Required(Current User Logged In)

Path:         `PUT  '/layovers/:id/delete'`

Parameters:

| Name            | Type        | Description
|-----------------|-------------|-------------
| layover id      | integer     |assigned at creation                      

Example data successful response:
```json
{
  "message": "Layover has been deleted"
}
 Response Status Code: 200 OK
 
 Example data unsuccessful response:
 {
  "message": "Nothing at /layovers/17/delete"
  }
Response Status Code: 404 Not Found
```
## Find a possible meetup

Access-Token:          Required(Current User Logged In)

Path:           `GET '/layovers/:id'`

Parameters:

| Name               | Type        | Description
|--------------------|-------------|-------------
|id of trip you want | integer     |assigned at creation  

Example data successful response:
```json
 {
    "id": 10,
    "layover_info": {
      "arrival_time": "2015-07-16T12:29:06.000Z",
      "departure_time": "2015-07-16T17:29:06.000Z",
      "city": "Atlanta",
      "airport": "ATL",
      "display_user_info": true,
      "created_at": "2015-07-15T19:54:55.739Z",
      "updated_at": "2015-07-15T19:54:55.739Z"
    },
    "creator": {
      "user_name": "the",
      "first_name": "iron",
      "last_name": "yard",
      "email": "the@iron.yard"
    }
  },
  {
    "id": 7,
    "layover_info": {
      "arrival_time": "2015-07-16T13:45:06.000Z",
      "departure_time": "2015-07-16T17:29:06.000Z",
      "city": "Atlanta",
      "airport": "ATL",
      "display_user_info": true,
      "created_at": "2015-07-15T19:38:43.974Z",
      "updated_at": "2015-07-15T19:38:43.974Z"
    },
    "creator": {
      "user_name": "our",
      "first_name": "leet",
      "last_name": "app",
      "email": "our@leet.app"
    }
  }
  Response Status Code: 200 OK
```