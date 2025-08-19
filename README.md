# SkillSwap 🛠️🤝

A minimal MVP Flutter app for skill exchange — users can offer a skill and request one in return. Built entirely with **Flutter** and **local storage**, this version is ideal for demonstrating core logic without a backend.

---

## 📱 App Features

### 👤 Demo Login
- Email: `demo@skillswap.com`
- Password: `password`
- No real auth — used to simulate login flow

### 🧑‍🎓 User Profile
- Name, location, and short bio
- Skills Offered & Skills Wanted (tag-based)
- Edit profile information
- View your own skill posts

### 📋 Skill Posts
- Add skill you offer & want in return
- Optional availability
- Posts stored locally on device
- Delete your own posts

### 🔍 Browse & Search
- View all user skill posts
- Filter by skill offered/wanted
- Tag-based filtering (e.g., "Cooking", "JavaScript", "Guitar")
- Search functionality

### 🤝 Matching Engine
- Find users where:
  - A's offered skill = B's wanted skill
  - B's offered skill = A's wanted skill
- Matching posts are highlighted

### 💬 Messaging (MVP)
- Once matched, user can send a simulated first message
- One-way confirmation only (no chat backend)

### 📞 Floating Contact Button
- Beautiful glassmorphism floating contact button on all screens
- Always accessible contact information
- Animated interactions with smooth scaling effects
- Contact popup with developer information

---

## 🛠 Tech Stack

| Layer         | Stack                 |
|---------------|------------------------|
| Frontend      | Flutter (Material UI)  |
| State Mgmt    | Provider               |
| Storage       | SharedPreferences      |
| Auth          | Demo only              |
| Hosting       | Not applicable         |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or iOS Simulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd skillswap
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Demo Credentials
- **Email:** `demo@skillswap.com`
- **Password:** `password`

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user.dart
│   ├── skill_post.dart
│   └── match.dart
├── providers/                # State management
│   ├── auth_provider.dart
│   ├── user_provider.dart
│   └── skill_provider.dart
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── browse_screen.dart
│   ├── profile_screen.dart
│   ├── matches_screen.dart
│   └── add_post_screen.dart
└── widgets/                  # Reusable widgets
    └── skill_post_card.dart
```

---

## 🔧 Key Features Implementation

### Authentication
- Simple demo login with hardcoded credentials
- Persistent login state using SharedPreferences
- Logout functionality

### User Management
- User profile with editable fields
- Skills management (add/remove tags)
- Local storage of user data

### Skill Posts
- Create posts with offered and wanted skills
- Optional availability field
- Local storage and retrieval
- Delete functionality for own posts

### Matching Algorithm
- Automatic matching when skills align
- Bidirectional matching (A offers what B wants, B offers what A wants)
- Visual indicators for matched posts

### Search & Filter
- Text-based search across skills and user names
- Filter by skill type (offered/wanted)
- Real-time search results

---

## 🎨 UI/UX Features

- **Material Design 3** implementation
- **Responsive layout** for different screen sizes
- **Color-coded skills** (green for offered, orange for wanted)
- **Match indicators** with heart icons
- **Smooth animations** and transitions
- **Intuitive navigation** with bottom tabs
- **Glassmorphism floating contact button** with beautiful animations

---

## 📱 Screenshots

The app includes the following main screens:

1. **Login Screen** - Beautiful gradient background with demo credentials
2. **Browse Screen** - Search and filter skill posts
3. **Matches Screen** - View your skill matches
4. **Add Post Screen** - Create new skill exchange posts
5. **Profile Screen** - Manage your profile and posts

---

## 🔮 Future Enhancements

- Real backend integration
- Push notifications for matches
- Chat functionality
- Skill verification system
- Location-based matching
- Skill categories and tags
- User ratings and reviews
- Video call integration

---

## 🤝 Contributing

This is a demo project, but contributions are welcome! Feel free to:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design system
- The open-source community for various packages

---

## 📞 Contact Information

**Developer:** Krupakar Gurije  
**Email:** krupakargurije@gmail.com  
**GitHub:** [github.com/krupakargurije](https://github.com/krupakargurije)  
**LinkedIn:** [linkedin.com/in/krupakargurije](https://www.linkedin.com/in/gurije-krupakar)

---

**Built with ❤️ using Flutter** 