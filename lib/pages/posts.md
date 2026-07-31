# Posts Page Explained (Flutter + GetX + API Data Display)

The `Posts` class is the UI screen that displays posts fetched from an API.

It uses:

- **GetView** → To access `PostController`.
- **Obx** → To automatically rebuild the UI when reactive data changes.
- **ListView.builder** → To display a dynamic list of posts.
- **FloatingActionButton** → To trigger API calls manually.

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class Posts extends GetView<PostController> {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.fetchPosts();
        },
        child: Icon(CupertinoIcons.refresh),
      ),
      appBar: AppBar(
        title: Text("Api Call Example"),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(controller.posts[index].title),
                    subtitle: Text(controller.posts[index].body),
                  );
                },
              ),
      ),
    );
  }
}
```

---

# 1. Import Statements

```dart
import 'package:flutter/cupertino.dart';
```

Provides Cupertino widgets and icons.

Example:

```dart
CupertinoIcons.refresh
```

creates an iOS-style refresh icon.

---

```dart
import 'package:flutter/material.dart';
```

Provides Material Design widgets:

- `Scaffold`
- `AppBar`
- `FloatingActionButton`
- `ListTile`
- `CircularProgressIndicator`

---

```dart
import 'package:get/get.dart';
```

Imports GetX features:

- `GetView`
- `Obx`
- Dependency Injection
- State Management

---

```dart
import '../controllers/post_controller.dart';
```

Imports the controller that manages:

- API calls
- Post data
- Loading state

---

# 2. Extending GetView

```dart
class Posts extends GetView<PostController>
```

Instead of:

```dart
class Posts extends StatelessWidget
```

the page extends:

```dart
GetView<PostController>
```

This gives direct access to:

```dart
controller
```

inside the widget.

---

## Without GetView

You would need:

```dart
final controller = Get.find<PostController>();
```

Then:

```dart
controller.fetchPosts();
```

---

## With GetView

You directly write:

```dart
controller.fetchPosts();
```

GetX automatically finds the `PostController` registered in:

```dart
PostBinding()
```

---

# 3. Scaffold

```dart
return Scaffold(
```

`Scaffold` provides the basic page structure.

It contains:

- AppBar
- Body
- Floating Action Button

---

# 4. Floating Action Button

```dart
floatingActionButton: FloatingActionButton(
```

Creates the floating button at the bottom-right corner.

---

## Button Action

```dart
onPressed: () {
  controller.fetchPosts();
},
```

When the user presses refresh:

```
User taps refresh button

        ↓

controller.fetchPosts()

        ↓

API request starts

        ↓

Posts are loaded

        ↓

UI updates
```

The UI does not directly call the API.

The controller handles all business logic.

---

## Icon

```dart
Icon(CupertinoIcons.refresh)
```

Displays the refresh icon.

---

# 5. AppBar

```dart
appBar: AppBar(
  title: Text("Api Call Example"),
  centerTitle: true,
),
```

Creates the top navigation bar.

Displays:

```
        Api Call Example
```

The title is centered.

---

# 6. Obx Widget

```dart
body: Obx(
```

This is the main GetX feature in this page.

`Obx` listens to reactive variables from the controller.

In this case, it watches:

```dart
controller.isLoading
```

and:

```dart
controller.posts
```

Whenever these values change, the UI rebuilds automatically.

---

# 7. Loading Condition

```dart
controller.isLoading
    ? Center(
        child: CircularProgressIndicator(),
      )
```

This is a ternary operator.

Meaning:

If:

```dart
controller.isLoading == true
```

show:

```
Loading spinner
```

Otherwise:

show the posts list.

---

## Loading Flow

```
fetchPosts()

      ↓

_isLoading = true

      ↓

Obx rebuilds

      ↓

CircularProgressIndicator shown

      ↓

API finishes

      ↓

_isLoading = false

      ↓

Obx rebuilds again

      ↓

Posts list shown
```

---

# 8. CircularProgressIndicator

```dart
CircularProgressIndicator()
```

Shows a loading animation while the API request is running.

Example:

```
      ⟳
 Loading...
```

---

# 9. ListView.builder

```dart
ListView.builder(
```

Used to display a dynamic list.

Unlike a normal `ListView`, it creates items only when needed.

Advantages:

- Better performance.
- Works well with large lists.

---

# 10. Item Count

```dart
itemCount: controller.posts.length,
```

Defines how many list items should be created.

Example:

If API returns:

```
100 posts
```

then:

```dart
controller.posts.length
```

is:

```
100
```

So Flutter creates 100 list items.

---

# 11. Item Builder

```dart
itemBuilder: (context, index) {
```

Builds each item.

Example:

```
index = 0  → First post
index = 1  → Second post
index = 2  → Third post
```

---

# 12. ListTile

```dart
return ListTile(
```

Creates a standard list item.

It contains:

- Title
- Subtitle
- Leading icon
- Trailing icon

---

# 13. Display Post Title

```dart
title: Text(
    controller.posts[index].title
),
```

Gets the title from the PostModel.

Example:

```dart
controller.posts[0].title
```

returns:

```
Flutter GetX Tutorial
```

---

# 14. Display Post Body

```dart
subtitle: Text(
    controller.posts[index].body
),
```

Displays the post description.

Example:

```
Learning Flutter state management
```

---

# Complete Data Flow

```
User Opens Posts Page

        │

        ▼

Posts Widget Created

        │

        ▼

GetView Finds PostController

        │

        ▼

User Presses Refresh Button

        │

        ▼

controller.fetchPosts()

        │

        ▼

PostApiService Calls API

        │

        ▼

JSON Response Received

        │

        ▼

Converted to List<PostModel>

        │

        ▼

RxList Updated

        │

        ▼

Obx Detects Change

        │

        ▼

ListView Displays Posts
```

---

# Connection Between All Files

Your project flow:

```
Pages.dart
    │
    ▼
PostBinding
    │
    ▼
PostController
    │
    ▼
PostApiService
    │
    ▼
API
    │
    ▼
PostModel
    │
    ▼
Posts UI
```

---

# GetX Features Used Here

| GetX Feature | Usage |
|---|---|
| `GetView<PostController>` | Provides controller access |
| `controller` | Accesses PostController methods and data |
| `Obx` | Automatically rebuilds UI |
| `PostBinding` | Injects PostController |
| `RxList` | Tracks post list changes |
| `RxBool` | Tracks loading state |

---

# Summary

The `Posts` page is the UI layer of your GetX architecture.

It:

- Extends `GetView<PostController>` to access the controller.
- Calls `fetchPosts()` when the refresh button is pressed.
- Uses `Obx` to listen to reactive variables.
- Shows a loading indicator while fetching data.
- Uses `ListView.builder` to display posts.
- Reads data from `PostModel` objects.
- Automatically updates when the controller state changes.

The complete flow is:

**Button → Controller → API Service → Model → Rx State → Obx → UI Update**