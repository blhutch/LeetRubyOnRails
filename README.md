# LeetRubyOnRails 

# API

## Overview

All access is over HTTPS, and access from the "https://vast-wildwood-6662.herokuapp.com" domain. All data is sent and received as JSON.

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