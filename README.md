Inventory Management App

A real-time Flutter inventory app using Firebase Firestore. Users can create, read, update, and delete inventory items while the UI updates in real time. Built with a clean architecture to separate UI and data layers for maintainability.

Features
Core Features (CRUD + Real-time)
Add Item: Users can add items with a name, quantity, and price.
View Items: Real-time item list powered by StreamBuilder and ListView.builder.
Update Item: Edit details of existing items.
Delete Item: Remove items from the inventory.
Form Validation: Ensures no empty fields and numeric validation for quantity/price.
Enhanced Features
Search Functionality: Users can search items by name in real time.
Low Stock Highlight: Items with quantity below a certain threshold are highlighted in red.
(These enhancements improve usability and make inventory management easier.)
Tech Stack
Flutter
Dart
Firebase Firestore
StreamBuilder for real-time updates
Clean Architecture with a dedicated service layer
Setup Instructions
Clone the repository
git clone git@github.com:Sattwikk/inventory_management_app.git
cd inventory_management_app
Install dependencies
flutter pub get
Configure Firebase
Connect your app to Firebase using FlutterFire CLI.
Enable Firestore in test mode for development.
Ensure google-services.json (Android) or GoogleService-Info.plist (iOS) is properly placed in the project.
Run the app
flutter run
APK

The release APK is included at:

build/app/outputs/flutter-apk/app-release.apk

You can install this APK on Android devices to test the app.

Reflection

During this activity, I developed a Flutter app integrated with Firebase Firestore for real-time inventory management.

Challenges faced:

Handling form validation for quantity and price fields.
Ensuring UI updates instantly when data changes in Firestore.

Learnings & Takeaways:

Implementing real-time updates using StreamBuilder.
Structuring Flutter apps with a service layer for maintainability.
Adding enhanced features like search and low-stock highlighting to improve UX.

This project strengthened my understanding of Flutter CRUD operations, Firestore integration, and clean app architecture.