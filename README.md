# German Board

A comprehensive Flutter-based educational platform designed to provide interactive learning experiences through live training sessions, recorded courses, and on-site training programs.

## 📱 Overview

German Board is a modern Learning Management System (LMS) that enables users to access various training programs, participate in live interactive sessions, watch recorded courses, and manage their learning journey all in one place. The application supports multiple languages, offers a seamless payment experience, and provides real-time notifications to keep users engaged.

## ✨ Key Features

### 🔐 Authentication & Security
- **Multi-method Authentication**: Email/Phone registration and login
- **OTP Verification**: Secure OTP-based verification for registration and password reset
- **Google Sign-In**: Quick authentication using Google accounts
- **Password Management**: Forgot password functionality with secure reset process
- **Security Settings**: Comprehensive security options for account protection

### 🎓 Training & Learning
- **Live Training Sessions**: Real-time interactive training using Agora RTC engine
  - Video conferencing capabilities
  - Real-time messaging (RTM)
  - Session notes and materials
- **Recorded Training Courses**: Access to pre-recorded video courses
  - Video player with playback controls
  - Course progress tracking
  - Lesson-based structure
- **On-Site Training**: Information and enrollment for physical training programs
- **My Courses**: Centralized dashboard to manage enrolled courses
- **Quiz System**: Interactive quizzes for course assessment

### 📚 Content & Discovery
- **Blogs**: Educational articles and blog posts
- **Categories**: Browse training programs by category
- **Search Functionality**: Find courses, blogs, and content quickly
- **Certificate Search**: Verify and search for training certificates

### 💳 Payments
- **Stripe Integration**: Secure payment processing for course enrollment
- **Payment Management**: Seamless checkout experience

### 🔔 Notifications
- **Push Notifications**: Firebase Cloud Messaging integration
- **Local Notifications**: In-app notification system
- **Notification History**: View and manage all notifications
- **Customizable Settings**: Control notification preferences

### 👤 Profile Management
- **User Profile**: Complete profile management with edit capabilities
- **Language Selection**: Multi-language support with localization
- **Theme Customization**: Light and dark mode support
- **Settings**: Comprehensive app settings and preferences
- **Complaint System**: Submit and track complaints

### 🌐 Internationalization
- **Multi-language Support**: Localized content for different languages
- **RTL Support**: Right-to-left language support
- **Dynamic Language Switching**: Change language on the fly

## 🛠️ Technologies Used

### Core Framework
- **Flutter** (SDK ^3.5.4): Cross-platform mobile development framework
- **Dart**: Programming language

### State Management & Architecture
- **GetX** (^4.6.6): State management, dependency injection, and routing
- **GetX Pattern**: Clean architecture with controllers, bindings, and views

### Backend Services
- **Firebase Core** (^3.12.1): Firebase initialization
- **Firebase Auth** (^5.5.1): User authentication
- **Firebase Messaging** (^15.2.7): Push notifications
- **Dio** (^5.4.2+1): HTTP client for API communication

### Real-Time Communication
- **Agora RTC Engine** (^6.5.0): Live video/audio streaming for training sessions
- **Agora RTM** (^2.2.2): Real-time messaging

### Payment Processing
- **Flutter Stripe** (^11.4.0): Payment gateway integration

### Local Storage
- **Hive** (^2.2.3): Fast, lightweight NoSQL database
- **Hive Flutter** (^1.1.0): Flutter integration for Hive
- **Shared Preferences** (^2.2.3): Key-value storage for app preferences

### UI/UX Libraries
- **Google Fonts** (^6.2.1): Custom typography
- **Flutter ScreenUtil** (^5.9.3): Responsive design utilities
- **Adaptive Theme** (^3.6.0): Theme management (light/dark mode)
- **Animated Bottom Navigation Bar** (^1.3.3): Enhanced navigation
- **Table Calendar** (^3.0.9): Calendar widget
- **Flutter SVG** (^2.0.17): SVG image support
- **Line Icons** (^2.0.3) & **Font Awesome** (^10.7.0): Icon libraries

### Media & Files
- **Image Picker** (^1.1.1): Image selection from gallery/camera
- **Video Player** (^2.8.1): Video playback
- **Chewie** (^1.7.4): Advanced video player controls
- **Gallery Saver Plus** (^3.2.4): Save images to gallery
- **Open FileX** (^4.7.0): Open files with system apps

### Additional Features
- **Flutter TTS** (^4.2.3): Text-to-speech functionality
- **Permission Handler** (^12.0.0+1): Runtime permissions management
- **URL Launcher** (^6.3.1): Open URLs and external apps
- **Share Plus** (^10.1.4): Share content from the app
- **Flutter Local Notifications** (^19.2.1): Local notification system
- **Liquid Pull to Refresh** (^3.0.1): Pull-to-refresh animations
- **Rating Dialog** (^2.0.4): User rating prompts

### Development Tools
- **Build Runner**: Code generation
- **Flutter Lints** (^4.0.0): Linting rules
- **Flutter Intl** (^0.0.1): Internationalization utilities
- **Intl Utils** (^2.8.8): Localization tools

## 📁 Project Structure

```
lib/
├── Bindings/          # GetX bindings for dependency injection
├── Constants/         # App constants, routes, and colors
├── Controller/        # Business logic controllers
├── Models/            # Data models
├── Services/          # Service classes (Hive, Notifications, Stripe, etc.)
├── View/              # UI screens and widgets
│   ├── auth/          # Authentication screens
│   ├── blogs/         # Blog screens
│   ├── Live training/ # Live training screens
│   ├── my_courses/    # Course management screens
│   ├── on Site training/ # On-site training screens
│   ├── profile/       # Profile and settings screens
│   ├── recorded training/ # Recorded course screens
│   └── widgets/       # Reusable UI components
├── l10n/              # Localization files
├── generated/         # Generated code files
└── main.dart          # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.5.4 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase project setup
- Agora account (for live training features)
- Stripe account (for payment processing)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd germanboard
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `firebase_options.dart` file (or generate it using FlutterFire CLI)
   - Configure Firebase for Android and iOS platforms

4. **Configure Agora**
   - Set up Agora RTC and RTM credentials
   - Add credentials to your configuration files

5. **Configure Stripe**
   - Add your Stripe publishable key to the constants file

6. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 🔧 Configuration

### Environment Setup
- Ensure all API keys and credentials are properly configured
- Set up Firebase configuration files for each platform
- Configure Agora SDK credentials
- Add Stripe publishable keys

### Localization
The app supports multiple languages. Localization files are located in `lib/l10n/`. To add new languages:
1. Add language files in `lib/l10n/`
2. Update `supportedLocales` in `main.dart`

## 📱 Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Web (partial support)
- ✅ Windows (partial support)
- ✅ macOS (partial support)
- ✅ Linux (partial support)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is private and not intended for public distribution.

## 👥 Support

For support and inquiries, please contact the development team.

---

**Note**: This is a private project. Ensure all sensitive credentials and API keys are kept secure and not committed to version control.
