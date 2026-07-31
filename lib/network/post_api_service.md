# PostApiService Explained (Flutter + Dio + GetX)

The `PostApiService` class is responsible for communicating with the REST API. It fetches data from the internet, converts the JSON response into `PostModel` objects, and returns them to the `PostController`.

This follows the **Separation of Concerns** principle:

- **UI** → Displays data.
- **Controller** → Manages state and business logic.
- **API Service** → Handles network requests.
- **Model** → Represents the data.

```dart
import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/post_model.dart';

class Postapiservice {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  fetchPosts() async {
    try {
      var _response = await _dio.get('/posts');

      if (_response.statusCode == 200) {
        List<dynamic> data = _response.data;

        log(data.toString());

        return data.map((item) {
          return PostModel(
            userId: item['userId'],
            id: item['id'],
            title: item['title'],
            body: item['body'],
          );
        }).toList();
      } else {
        throw Exception('API could not be reached');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
```

---

# What is an API Service?

An **API Service** is a class responsible for making HTTP requests.

Instead of writing HTTP requests inside the UI or controller, they are placed inside a separate service class.

This makes the project:

- Cleaner
- Easier to maintain
- Easier to test
- Reusable

---

# Overall Architecture

```
Flutter UI
      │
      ▼
PostController
      │
      ▼
PostApiService
      │
      ▼
REST API
      │
      ▼
JSON Response
      │
      ▼
PostModel
      │
      ▼
Controller
      │
      ▼
UI Updates
```

---

# 1. Import Statements

```dart
import 'dart:developer';
```

Imports Dart's logging library.

Used for:

```dart
log(data.toString());
```

This prints the API response to the Debug Console.

Example:

```
[
 {userId:1,id:1,title:...,body:...},
 {userId:1,id:2,title:...,body:...}
]
```

---

```dart
import 'package:dio/dio.dart';
```

Imports the **Dio** package.

Dio is a powerful HTTP client for Flutter.

It supports:

- GET
- POST
- PUT
- DELETE
- Timeouts
- Interceptors
- File Uploads
- Authentication
- Error Handling

Compared to Flutter's `http` package, Dio provides more advanced features.

---

```dart
import '../models/post_model.dart';
```

Imports the `PostModel`.

The API returns JSON.

Your application uses `PostModel`.

So the service converts JSON into model objects.

---

# 2. Creating the API Service

```dart
class Postapiservice {
```

This class contains all network-related operations.

Currently it has one method:

```dart
fetchPosts()
```

In larger applications, it may also contain:

- createPost()
- updatePost()
- deletePost()
- fetchPostById()

---

# 3. Creating the Dio Client

```dart
final Dio _dio = Dio(
```

Creates a Dio object.

This object is responsible for sending HTTP requests.

---

# 4. BaseOptions

```dart
BaseOptions(
```

These are default settings for every request.

---

## Base URL

```dart
baseUrl: 'https://jsonplaceholder.typicode.com',
```

Instead of writing:

```dart
_dio.get(
'https://jsonplaceholder.typicode.com/posts'
);
```

You only write:

```dart
_dio.get('/posts');
```

Dio automatically combines them:

```
Base URL
https://jsonplaceholder.typicode.com

+

Endpoint
/posts

=

https://jsonplaceholder.typicode.com/posts
```

---

## Connection Timeout

```dart
connectTimeout: Duration(seconds:10)
```

Maximum time allowed to establish a connection.

If the server doesn't respond within 10 seconds:

```
Connection Timeout
```

---

## Receive Timeout

```dart
receiveTimeout: Duration(seconds:10)
```

After connecting,

if data is not received within 10 seconds,

Dio throws a timeout exception.

---

# 5. fetchPosts()

```dart
fetchPosts() async {
```

This asynchronous method fetches all posts from the API.

---

# 6. Try Block

```dart
try {
```

Used for exception handling.

If an error occurs,

execution jumps to the `catch` block.

---

# 7. Sending the GET Request

```dart
var _response = await _dio.get('/posts');
```

This sends:

```
GET

https://jsonplaceholder.typicode.com/posts
```

The `await` keyword pauses execution until the server responds.

---

# Response Flow

```
Flutter App

      │

GET /posts

      │

      ▼

REST API

      │

JSON Response

      │

      ▼

Flutter
```

---

# 8. Checking Status Code

```dart
if (_response.statusCode == 200)
```

HTTP Status Code **200** means:

```
Request Successful
```

Other common status codes:

| Code | Meaning |
|------|---------|
| 200 | Success |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 404 | Not Found |
| 500 | Internal Server Error |

If the status code is not 200:

```dart
throw Exception(
'API could not be reached'
);
```

---

# 9. Reading JSON Data

```dart
List<dynamic> data = _response.data;
```

The API returns a JSON array.

Example:

```json
[
  {
    "userId":1,
    "id":1,
    "title":"Hello",
    "body":"World"
  }
]
```

This becomes:

```dart
List<dynamic>
```

Each item is a map.

---

# 10. Logging the Response

```dart
log(data.toString());
```

Prints the JSON in the Debug Console.

Useful during development.

---

# 11. Mapping JSON to Models

```dart
return data.map((item) {
```

`map()` transforms each JSON object into a `PostModel`.

Example:

```
JSON

↓

PostModel

↓

PostModel

↓

PostModel
```

---

Inside the map:

```dart
PostModel(
    userId: item['userId'],
    id: item['id'],
    title: item['title'],
    body: item['body'],
)
```

Each JSON object becomes a Dart object.

Example:

JSON:

```json
{
 "userId":1,
 "id":2,
 "title":"Flutter",
 "body":"Learning GetX"
}
```

Becomes:

```dart
PostModel(
    userId:1,
    id:2,
    title:"Flutter",
    body:"Learning GetX",
)
```

---

# 12. Converting to List

```dart
}).toList();
```

`map()` returns an iterable.

`toList()` converts it into:

```dart
List<PostModel>
```

Which is returned to the controller.

---

# Data Conversion Flow

```
JSON Array

        │

        ▼

map()

        │

        ▼

PostModel

        │

        ▼

List<PostModel>
```

---

# 13. Error Handling

```dart
catch (e) {
    throw e.toString();
}
```

If anything fails:

- Internet connection
- Timeout
- Server error
- Invalid response

the exception is caught and rethrown.

Example:

```
SocketException

↓

catch

↓

throw error
```

The `PostController` or UI can then display an error message.

---

# Complete Flow

```
User Opens Screen

        │

        ▼

PostController.fetchPosts()

        │

        ▼

PostApiService.fetchPosts()

        │

        ▼

Dio GET Request

        │

        ▼

REST API

        │

        ▼

JSON Response

        │

        ▼

Convert JSON

        │

        ▼

List<PostModel>

        │

        ▼

Return to Controller

        │

        ▼

RxList Updated

        │

        ▼

Obx Rebuilds

        │

        ▼

ListView Displays Posts
```

---

# Why Use Dio?

Compared to the basic `http` package, Dio offers:

- Simpler configuration with `BaseOptions`.
- Built-in timeout support.
- Powerful interceptors for logging or authentication.
- Automatic JSON decoding.
- Better error handling.
- Support for file uploads and downloads.

---

# Summary

The `PostApiService` is the network layer of the application.

It:

- Uses **Dio** to make HTTP requests.
- Configures a reusable HTTP client with `BaseOptions`.
- Sends a **GET** request to `/posts`.
- Checks the HTTP status code.
- Converts the JSON response into `PostModel` objects.
- Returns a `List<PostModel>` to the `PostController`.
- Handles network errors using `try-catch`.
- Keeps API-related code separate from the controller and UI, following clean architecture principles.
```