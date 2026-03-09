# WeChat - Flutter Messaging App

A feature-rich Flutter messaging application built with clean architecture principles, real-time communication support, and modern state management.

## Project Overview

WeChat is a Flutter-based messaging application that includes user authentication, real-time chat functionality, user profiles, and home feed management. The project is built following clean architecture patterns with BLoC state management.

**Current Version**: 1.0.0+1  
**Flutter SDK**: ^3.10.8

## Key Features

- **User Authentication**: Secure login and registration with encrypted storage
- **Real-time Messaging**: WebSocket-based chat with Socket.IO integration
- **User Profiles**: Profile management and viewing
- **Home Feed**: Dynamic home screen with user interactions
- **Theme Support**: Light and dark theme switching
- **Image Picking**: Built-in image selection for profiles and messages
- **Secure Storage**: Encrypted local storage for sensitive data

## Technology Stack

### Core Framework & State Management

- **Flutter**: ^3.10.8
- **flutter_bloc**: ^9.1.1 - State management
- **go_router**: ^17.1.0 - Navigation and routing

### Networking & Data

- **dio**: ^5.9.1 - HTTP client
- **socket_io_client**: ^3.1.4 - Real-time WebSocket communication
- **fpdart**: ^1.2.0 - Functional programming utilities

### Storage & Security

- **flutter_secure_storage**: ^10.0.0 - Encrypted local storage

### UI & Assets

- **flutter_svg**: ^2.2.3 - SVG rendering
- **cupertino_icons**: ^1.0.8 - iOS-style icons
- **shimmer**: ^3.0.0 - Loading shimmer effects
- **flutter_spinkit**: ^5.2.2 - Loading spinners

### Dependency Injection

- **get_it**: ^9.2.1 - Service locator

### Media

- **image_picker**: ^1.2.1 - Image selection from device

## Project Structure

```
wechat/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── splash_screen.dart           # Splash screen
│   ├── init_dependencies.dart       # Dependency injection setup
│   │
│   ├── common/                      # Shared resources
│   │   ├── entities/                # Common data models/entities
│   │   ├── theme/                   # App theming (AppTheme, ThemeCubit)
│   │   ├── usecase/                 # Abstract use cases base classes
│   │   └── widgets/                 # Reusable UI components
│   │
│   ├── core/                        # Core utilities and configuration
│   │   ├── error/                   # Error handling and exceptions
│   │   ├── router/                  # Navigation routes (GoRouter setup)
│   │   └── utils/                   # Utilities (socket_service, helpers)
│   │
│   └── features/                    # Feature modules (clean architecture)
│       ├── auth/                    # Authentication feature
│       │   ├── data/               # Data layer (repositories, datasources)
│       │   ├── domain/             # Domain layer (entities, repositories, usecases)
│       │   └── presentation/       # UI layer (pages, widgets, blocs)
│       │
│       ├── chat/                    # Chat/Messaging feature
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       ├── home/                    # Home feed feature
│       │   ├── data/
│       │   ├── domain/
│       │   └── presentation/
│       │
│       └── profile/                 # User profile feature
│           ├── data/
│           ├── domain/
│           └── presentation/
│
├── assets/                          # App assets
│   ├── icons/                       # SVG and icon files
│   └── images/                      # Image assets
│
├── pubspec.yaml                     # Project dependencies and configuration
├── analysis_options.yaml            # Lint rules
└── test/                            # Unit and widget tests
```

## Folder Architecture Breakdown

### `/lib/features`

Contains feature modules following **Clean Architecture**:

- **data**: External data sources, repository implementations, API clients
- **domain**: Business logic, entities, abstract repositories, use cases
- **presentation**: UI pages, BLoC state management, widgets

### `/lib/common`

Shared resources used across multiple features:

- Reusable widgets
- App theming and styling
- Common entities and data models
- Base classes for use cases

### `/lib/core`

Core application infrastructure:

- Routing configuration (GoRouter)
- Error handling strategies
- Utility functions and services (Socket.IO integration)

## Setup & Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (^3.10.8)
- [Dart](https://dart.dev/get-dart) (included with Flutter)
- Android Studio or Xcode (for mobile development)
- A code editor (VS Code or Android Studio)

### Installation Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/wechat.git
   cd wechat
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Build Files**

   ```bash
   flutter pub run build_runner build
   ```

4. **Run the App**

   ```bash
   flutter run
   ```

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [Socket.IO Client](https://pub.dev/packages/socket_io_client)
