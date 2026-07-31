# PostModel Explained (Flutter Model Class)

The `PostModel` class represents a **single post** in your application.

A **model** is a Dart class that defines the structure of data used in your app.

For example, if an API returns:

```json
{
    "userId": 1,
    "id": 5,
    "title": "Flutter GetX Tutorial",
    "body": "This is a sample post."
}
```

This JSON object can be stored inside a `PostModel` object.

```dart
class PostModel {
  final int userId, id;
  final String title, body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}
```

---

# What is a Model?

A **Model** is simply a Dart class that represents data.

Think of it as a blueprint.

```
API JSON
     │
     ▼
PostModel Object
     │
     ▼
Flutter UI
```

Instead of working with raw JSON (`Map<String, dynamic>`), we work with strongly typed Dart objects.

---

# 1. Class Declaration

```dart
class PostModel {
```

This creates a new class named `PostModel`.

Each object of this class represents **one post**.

Example:

```dart
PostModel post;
```

---

# 2. Fields (Properties)

```dart
final int userId, id;
```

These two integer properties store:

- `userId` → The ID of the user who created the post.
- `id` → The unique ID of the post.

Example:

```json
{
    "userId": 1,
    "id": 10
}
```

becomes

```dart
userId = 1
id = 10
```

---

```dart
final String title, body;
```

These are string properties.

- `title` → The title of the post.
- `body` → The content of the post.

Example:

```json
{
    "title": "Flutter",
    "body": "Learning GetX is fun."
}
```

becomes

```dart
title = "Flutter"

body = "Learning GetX is fun."
```

---

# Why `final`?

```dart
final int id;
```

`final` means the value can only be assigned **once**.

After the object is created, the value cannot change.

Example:

```dart
PostModel post = PostModel(
    userId: 1,
    id: 2,
    title: "Hello",
    body: "World",
);
```

This is allowed.

But later:

```dart
post.id = 5;
```

This is **not allowed** because `id` is `final`.

Benefits:

- Prevents accidental changes.
- Makes objects immutable.
- Safer to use throughout the application.

---

# 3. Constructor

```dart
PostModel({
  required this.userId,
  required this.id,
  required this.title,
  required this.body,
});
```

This is the constructor.

It is called whenever a new `PostModel` object is created.

Example:

```dart
PostModel post = PostModel(
  userId: 1,
  id: 10,
  title: "Flutter",
  body: "Learning GetX",
);
```

The values are assigned automatically because of `this`.

Equivalent code:

```dart
PostModel({
  required int userId,
  required int id,
  required String title,
  required String body,
}) {
  this.userId = userId;
  this.id = id;
  this.title = title;
  this.body = body;
}
```

Dart's shorthand (`this.userId`) is cleaner and more concise.

---

# What Does `required` Mean?

```dart
required this.title
```

`required` means the caller **must** provide a value.

Correct:

```dart
PostModel(
    userId: 1,
    id: 5,
    title: "Flutter",
    body: "Learning GetX",
);
```

Incorrect:

```dart
PostModel(
    userId: 1,
    id: 5,
);
```

This produces a compile-time error because `title` and `body` are missing.

Benefits:

- Prevents incomplete objects.
- Improves code safety.
- Makes the constructor self-documenting.

---

# Creating an Object

Example:

```dart
PostModel post = PostModel(
  userId: 3,
  id: 15,
  title: "Flutter GetX",
  body: "State management made easy.",
);
```

Now you can access the data:

```dart
print(post.userId);
print(post.id);
print(post.title);
print(post.body);
```

Output:

```
3
15
Flutter GetX
State management made easy.
```

---

# Relationship with API

Suppose the API returns:

```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "First Post",
    "body": "Hello World"
  }
]
```

Each JSON object is converted into a `PostModel`.

```
JSON
     │
     ▼
PostModel
     │
     ▼
List<PostModel>
     │
     ▼
Controller
     │
     ▼
UI
```

Your `PostApiService` will typically create these objects and return:

```dart
List<PostModel>
```

The `PostController` then stores them in:

```dart
RxList<PostModel>
```

Finally, the UI displays each post.

---

# Data Flow

```
HTTP API
    │
    ▼
JSON Response
    │
    ▼
PostModel Objects
    │
    ▼
List<PostModel>
    │
    ▼
PostController
    │
    ▼
Obx
    │
    ▼
Flutter UI
```

---

# Example Usage in UI

```dart
ListView.builder(
  itemCount: controller.posts.length,
  itemBuilder: (context, index) {

    PostModel post = controller.posts[index];

    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body),
    );

  },
);
```

Each item in `controller.posts` is a `PostModel` object.

---

# Summary

The `PostModel` class is a **data model** that represents a single post.

It:

- Defines the structure of a post.
- Stores `userId`, `id`, `title`, and `body`.
- Uses `final` to create immutable objects.
- Uses a constructor with `required` parameters to ensure all data is provided.
- Makes it easier to work with API data in a type-safe way.
- Acts as a bridge between the JSON response from the API and the Flutter UI.