# Pages Class Explained (GetX Routing)

The `Pages` class is responsible for defining **all application routes** using GetX. It tells GetX:

- Which page should open for a specific route.
- Which binding (dependencies) should be loaded before the page opens.

```dart
import 'package:get/get.dart';

import '../bindings/counter_binding.dart';
import '../bindings/post_binding.dart';
import '../pages/counter.dart';
import '../pages/posts.dart';

class Pages {

  List<GetPage> getAllPages() {

    return [

      GetPage(
        name: '/counter',
        page: () => Counter(),
        binding: CounterBinding(),
      ),

      GetPage(
        name: '/post',
        page: () => Posts(),
        binding: PostBinding(),
      ),

    ];
  }

}
```

---

# 1. Import Statements

```dart
import 'package:get/get.dart';
```

Imports the **GetX** package.

It provides:

- `GetPage`
- Named Routing
- Navigation
- Bindings
- Dependency Injection

---

```dart
import '../bindings/counter_binding.dart';
```

Imports the binding for the Counter page.

This binding registers:

```dart
CounterController
```

before the Counter page is opened.

---

```dart
import '../bindings/post_binding.dart';
```

Imports the binding for the Post page.

This binding registers:

```dart
PostController
```

before the Post page is opened.

---

```dart
import '../pages/counter.dart';
```

Imports the Counter screen.

---

```dart
import '../pages/posts.dart';
```

Imports the Posts screen.

---

# 2. Pages Class

```dart
class Pages {
```

This class acts as the **central routing configuration**.

Instead of defining routes throughout the project, all routes are stored in one place.

Benefits:

- Easier to manage
- Cleaner project structure
- Easy to add new screens

---

# 3. Returning All Routes

```dart
List<GetPage> getAllPages() {
```

This method returns a list of all application routes.

Return type:

```dart
List<GetPage>
```

Each `GetPage` represents one screen in the application.

---

# 4. Counter Route

```dart
GetPage(
  name: '/counter',
  page: () => Counter(),
  binding: CounterBinding(),
),
```

This route tells GetX:

### Route Name

```dart
name: '/counter'
```

The URL (or route name) used for navigation.

Navigate to it using:

```dart
Get.toNamed('/counter');
```

---

### Page

```dart
page: () => Counter()
```

This tells GetX which widget to display.

When navigating to `/counter`, GetX creates:

```dart
Counter()
```

---

### Binding

```dart
binding: CounterBinding()
```

Before opening the page,

GetX executes:

```dart
CounterBinding()
```

which registers:

```dart
CounterController
```

using:

```dart
Get.lazyPut(() => CounterController());
```

So when the page opens,

`GetView<CounterController>` can automatically access the controller.

---

# Counter Navigation Flow

```
Get.toNamed('/counter')

        │
        ▼

Find Route

        │
        ▼

Execute CounterBinding

        │
        ▼

Register CounterController

        │
        ▼

Open Counter Page

        │
        ▼

Counter Widget Gets Controller
```

---

# 5. Post Route

```dart
GetPage(
  name: '/post',
  page: () => Posts(),
  binding: PostBinding(),
),
```

This route works exactly the same.

### Route Name

```dart
'/post'
```

Navigate using:

```dart
Get.toNamed('/post');
```

---

### Page

```dart
Posts()
```

The Posts screen is displayed.

---

### Binding

```dart
PostBinding()
```

Before the page opens,

GetX registers:

```dart
PostController
```

using:

```dart
Get.lazyPut(() => PostController());
```

---

# Post Navigation Flow

```
Get.toNamed('/post')

        │
        ▼

Find Route

        │
        ▼

Execute PostBinding

        │
        ▼

Register PostController

        │
        ▼

Open Posts Page

        │
        ▼

Posts Widget Gets Controller
```

---

# What is `GetPage`?

`GetPage` is a GetX class that combines three things into one place:

1. Route Name
2. Page Widget
3. Dependencies (Bindings)

General syntax:

```dart
GetPage(
    name: '/routeName',
    page: () => PageWidget(),
    binding: PageBinding(),
)
```

---

# Why Use `page: () => Counter()`?

Notice:

```dart
page: () => Counter()
```

instead of

```dart
page: Counter()
```

This is a **callback function**.

The page is created **only when navigation happens**, not when the application starts.

This improves performance because widgets are created lazily.

---

# Why Use Bindings with Routes?

Without bindings:

```dart
Get.to(Counter());
```

You would need to manually register the controller:

```dart
Get.put(CounterController());
```

before opening the page.

With bindings:

```dart
GetPage(
    binding: CounterBinding(),
)
```

GetX automatically registers the controller before the page is built.

No manual setup is needed.

---

# Complete Routing Flow

```
Application Starts
        │
        ▼
Pages.getAllPages()
        │
        ▼
Routes Registered
        │
        ▼
User Navigates
        │
        ▼
Get.toNamed('/post')
        │
        ▼
Find Matching Route
        │
        ▼
Execute Binding
        │
        ▼
Create Controller
        │
        ▼
Open Page
        │
        ▼
Page Uses Controller
```

---

# How It Connects with `GetMaterialApp`

Usually, these routes are supplied to `GetMaterialApp`:

```dart
GetMaterialApp(
  initialRoute: '/counter',
  getPages: Pages().getAllPages(),
)
```

Here:

- `initialRoute` decides the first screen.
- `getPages` provides all available routes.

Whenever you call:

```dart
Get.toNamed('/post');
```

GetX searches the list returned by:

```dart
Pages().getAllPages()
```

finds the matching route, loads its binding, and opens the page.

---

# Advantages of Using GetX Routing

- Centralized route management.
- Easy navigation using route names.
- Automatic dependency injection with bindings.
- Lazy page creation improves performance.
- No need to manually create controllers before opening pages.
- Makes large applications easier to organize.

---

# Summary

The `Pages` class acts as the application's **routing table**.

It:

- Stores all routes in one place.
- Returns a `List<GetPage>`.
- Defines route names such as `/counter` and `/post`.
- Specifies which widget should be displayed for each route.
- Associates each page with its corresponding binding.
- Automatically injects controllers before the page is created.
- Enables navigation using `Get.toNamed()` and `Get.offNamed()`.

This approach keeps routing, dependency injection, and page creation organized, making GetX applications cleaner, easier to maintain, and more scalable.