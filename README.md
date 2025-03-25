# Flutter with MVVM using Riverpod

A new Flutter project.

# What is Flutter
Flutter is an open-source UI software development kit created by Google. 
It allows developers to build cross-platform applications from a single codebase for various platforms including Android, iOS, web, Linux, macOS, and Windows.

# Key Features of Flutter

- Cross-Platform Development: Flutter enables developers to write a single codebase for multiple platforms, significantly reducing development time and costs.
- Hot Reload: This feature allows developers to see changes in real-time as they code, making the development process faster and more efficient.
- Rich UI: Flutter provides a rich set of customizable widgets that help create visually attractive and responsive user interfaces.
- High Performance: Flutter uses the Dart programming language and the Skia graphics engine, ensuring high performance, fast app startup times, and smooth animations.
- Strong Community Support: Flutter has a growing and supportive community, offering extensive documentation, resources, and third-party packages.
- Open-Source: Flutter is free and open-source, making it accessible to a wide range of developers.


# Functionality
- Using JSON file Show Category with product list
 
 ```
  Future<void> loadCategories() async {
    try {
      // Load JSON data from assets
      final String response =
          await rootBundle.loadString('assets/categories.json');
      final List<dynamic> data = json.decode(response);
      // Map the JSON to Category objects
      final categories = data.map((item) => Category.fromJson(item)).toList();
      state = AsyncValue.data(categories);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
 ```
 
 -Riverpod
 -SQFlite local database
 -MVVM Pattern

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
