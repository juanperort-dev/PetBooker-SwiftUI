# 🐾 PetBooker — SwiftUI Pet Services App

<p align="center">
  <a href="https://juanperort.dev">
    <img src="https://img.shields.io/badge/Portfolio-juanperort.dev-111827?style=for-the-badge&logo=google-chrome&logoColor=white" alt="Portfolio" />
  </a>
  <a href="https://www.linkedin.com/in/juanperort/">
    <img src="https://img.shields.io/badge/LinkedIn-Juan%20Jos%C3%A9%20Per%C3%A1lvarez%20Ortiz-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn" />
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS-lightgrey.svg" alt="iOS" />
  <img src="https://img.shields.io/badge/UI-SwiftUI-blue.svg" alt="SwiftUI" />
  <img src="https://img.shields.io/badge/Backend-Supabase-3ECF8E.svg" alt="Supabase" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20%2B%20Coordinator-green.svg" alt="Architecture" />
  <img src="https://img.shields.io/badge/Testing-Swift%20Testing-orange.svg" alt="Testing" />
</p>

**PetBooker** is a SwiftUI-based, architecture-first iOS application that lays the groundwork for a modern pet services platform.  
The current codebase focuses on authentication, session orchestration, dependency injection, coordinator-based navigation, and a modular separation between presentation, domain, and data layers.

> 🚀 Explore this and other projects in my portfolio: **[juanperort.dev](https://juanperort.dev)**

---

## 🎬 Demo

- **App preview:** Screenshots and demo GIF coming soon
- **Portfolio case study:** [juanperort.dev](https://juanperort.dev)

---

## ✨ Why this project stands out

This project was built to showcase production-oriented iOS architecture rather than only UI composition.  
It emphasizes:

- Clear layer separation between **Presentation**, **Domain**, and **Data**
- **Coordinator-driven navigation** for scalable app flows
- **Dependency Injection** through a centralized container
- **Use Case** and **Repository** abstractions for maintainability
- A structure prepared for **testing**, feature growth, and backend integration

---

## ✅ Current Scope

At its current stage, the project already includes a solid app foundation with:

- **Splash bootstrap flow**
- **Email/password authentication** with Supabase
- **Session-aware app routing**
- **Coordinator-based navigation** for authentication and main app flows
- **Tab-based main shell** with Dashboard and Profile sections
- **Logout flow** from the Profile screen
- **Unit tests** covering core login ViewModel behavior

---

## 🏗️ Architecture

PetBooker follows a modular architecture inspired by **Clean Architecture**, combined with **MVVM**, **Coordinators**, **Use Cases**, and the **Repository Pattern**.

- **Core**
  - App bootstrap
  - Dependency Injection container
  - Global configuration management
  - App-level coordination

- **Domain**
  - Business entities
  - Protocol abstractions
  - Session service contracts
  - Use cases such as login, logout, and session check

- **Data**
  - Remote data sources
  - Repository implementations
  - DTO mapping
  - Backend integration with Supabase

- **Presentation**
  - Flow coordinators
  - Screen modules
  - SwiftUI views
  - ViewModels for UI state and actions

---

## 🔐 Authentication & App Flow

The app currently follows this flow:

1. The application launches into a **Splash** state
2. The app attempts to restore or validate the current user session
3. A session check use case determines whether the user is authenticated
4. The user is routed either to:
   - the **authentication flow**, or
   - the **main application flow**
5. Once authenticated, the app displays a tab-based shell with:
   - **Dashboard**
   - **Profile**

This structure keeps navigation scalable and clean as the app grows.

---

## 🧱 Project Structure

```bash
PetBooker-SwiftUI/
├── Config/                         # Build configurations and environment keys
├── PetBooker-SwiftUI/
│   ├── Core/                       # AppCoordinator, DIContainer, Config
│   ├── Data/                       # Data sources, repositories, utils
│   ├── Domain/                     # Entities, protocols, services, use cases
│   ├── Presentation/
│   │   ├── Coordinators/           # Auth and main flow coordinators
│   │   ├── FlowViews/              # Flow entry points
│   │   └── Modules/                # Feature modules (Login, Register, Profile, etc.)
│   ├── Resources/                  # Assets and localization resources
│   └── Preview Content/            # SwiftUI preview assets
├── PetBooker-SwiftUITests/         # Mocks and ViewModel tests
└── PetBooker-SwiftUI.xcodeproj
```

---

## 🛠️ Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** Clean Architecture-inspired layering + MVVM + Coordinators
- **Backend / Auth:** Supabase
- **Dependencies:**
  - `supabase-swift` `2.5.1+`
  - `GoogleSignIn-iOS` `8.0.0+`
- **Patterns:** Repository Pattern, Use Cases, Dependency Injection
- **Testing:** Swift Testing
- **Configuration:** `xcconfig` files + `Info.plist` key injection

---

## 🧪 Testing

The project already includes targeted unit tests focused on the login flow.

Current test coverage includes:

- Login ViewModel navigation callbacks
- Successful login state transitions
- Failed login state handling
- Error message validation
- Domain-level mocking for isolated ViewModel testing

This is a strong base for expanding coverage as new features are added.

---

## ⚙️ Getting Started

### Requirements

- A recent version of **Xcode** compatible with your configured iOS SDK
- A valid **Supabase project**
- Supabase:
  - **Project URL**
  - **Anon key**

### Installation

1. Clone the repository:

```bash
git clone https://github.com/juanperort-dev/PetBooker-SwiftUI.git
```

2. Open the project:

```bash
open PetBooker-SwiftUI.xcodeproj
```

3. Configure your environment keys in the build configuration files inside `Config/`  
   You can use the template as reference.

4. Add your Supabase values:

```xcconfig
SUPABASE_URL = "YOUR_SUPABASE_URL"
SUPABASE_KEY = "YOUR_SUPABASE_ANON_KEY"
```

5. Make sure your `Info.plist` exposes the following keys:

- **SupabaseURL** → `$(SUPABASE_URL)`
- **SupabaseKey** → `$(SUPABASE_KEY)`

6. Build and run the app on the simulator or a physical device

> Tip: If needed, review the project deployment target in Xcode before running.

---

## 🚧 Roadmap

- [ ] Complete the registration flow and form validation
- [ ] Add real pet services / booking domain features
- [ ] Replace the dashboard placeholder with production-ready screens
- [ ] Finish end-to-end Google Sign-In support
- [ ] Expand profile and session management
- [ ] Increase unit and integration test coverage
- [ ] Add screenshots and a demo GIF to the README

---

## 👨‍💻 Author

**Juan José Perálvarez Ortiz**

iOS developer focused on building clean, scalable, and modern applications for Apple platforms.

- [Portfolio](https://juanperort.dev)
- [LinkedIn](https://www.linkedin.com/in/juanperort/)
